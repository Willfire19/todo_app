class RemoveUserIdFromTodos < ActiveRecord::Migration
  def up
    remove_column :todos, :user_id
  end

  def down
    add_column :todos, :user_id, :integer
  end
end
