class User < ApplicationRecord
    before_save {email.downcase!}
    validates :name,presence: true,length: { maximum: 50}
    validates :email,presence: true, uniqueness: {case_sensitive: false},format: {with: URI::MailTo::EMAIL_REGEXP}
    has_secure_password
    validates :password,presence: true,length: { minimum: 6, too_short: "minimum is 6 characters" }, allow_nil: true #allow empty password on update
    has_many :todos, dependent: :restrict_with_error
    has_many :todo_shares
    has_many :shared_todos,through: :todo_shares, source: :todo

    def archive
        update(soft_delete: true)
    end

    def isActive?
        !soft_delete
    end

    def clear_todo_shares
        todo_shares.update_all(user_id: nil)
    end

end
