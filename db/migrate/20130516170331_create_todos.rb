class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :entry
      t.date :dueDate
      t.date :assignedDate
      t.integer :priority

      t.timestamps
    end
  end
end
