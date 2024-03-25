class AddLengthConstraintToTodoTitle < ActiveRecord::Migration[7.1]
  def change
    change_column :todos, :title, :string, limit: 100
  end
end
