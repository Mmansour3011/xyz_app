class Todo < ApplicationRecord
    validates :title,presence: true,length: { maximum: 100, too_long: "maximum is 100 characters" }
    belongs_to :user
    validates :user_id ,presence: true
    has_one_attached :attachment
    has_many :todo_shares,  dependent: :destroy
    has_many :shared_users,through: :todo_shares, source: :user

    def share_with(users)
        Array(users).each do |user|
            todo_shares.create(user: user)
        end
    end
end
