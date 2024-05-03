class User < ApplicationRecord
    before_save {email.downcase!}
    validates :name,presence: true,length: { maximum: 50}
    validates :email,presence: true, uniqueness: {case_sensitive: false},format: {with: URI::MailTo::EMAIL_REGEXP}
    has_secure_password
    validates :password,presence: true,length: { minimum: 6, too_short: "minimum is 6 characters" }, allow_nil: true #allow empty password on update
    has_many :todos
end