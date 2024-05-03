class AddNotNullToTodoUserReference < ActiveRecord::Migration[7.1]

    def change
        change_column :todos, :user_id, :integer, null: false
    end

end