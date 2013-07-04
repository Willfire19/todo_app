class AddStatusToTodo < ActiveRecord::Migration
  def change
    add_column :todos, :status, :string, :default => "To Do"
  end
end
