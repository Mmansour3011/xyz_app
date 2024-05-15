class Todo < ApplicationRecord
    validates :title,presence: true,length: { maximum: 100, too_long: "maximum is 100 characters" }
    belongs_to :user
    validates :user_id ,presence: true
    has_one_attached :attachment

    
end
