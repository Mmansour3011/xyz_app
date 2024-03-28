class Todo < ApplicationRecord
    validates :title,presence: true,length: { maximum: 100, too_long: "maximum is 100 characters" }
    
end
