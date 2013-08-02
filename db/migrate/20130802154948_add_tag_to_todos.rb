class AddTagToTodos < ActiveRecord::Migration
  def change
  	add_column :todos, :tag, :string
  end
end
