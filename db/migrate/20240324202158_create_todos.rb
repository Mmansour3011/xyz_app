class CreateTodos < ActiveRecord::Migration[7.1]
  def change
    create_table :todos do |t|
      t.string :title, null: false
      t.text :content

      t.timestamps
    end
  end
end
