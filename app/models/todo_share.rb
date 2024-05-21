class TodoShare < ApplicationRecord 
    belongs_to :todo
    belongs_to :user
end