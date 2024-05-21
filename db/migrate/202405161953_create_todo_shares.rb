class CreateTodoShares < ActiveRecord::Migration[7.1]
    def change 
        create_table :todo_shares do |t|
          t.references :todo, null: false, foreign_key: true
          t.references :user, null: false, foreign_key: true
        
          t.timestamps
        end

        add_index :todo_shares, [:todo_id, :user_id], unique: true
    end
end