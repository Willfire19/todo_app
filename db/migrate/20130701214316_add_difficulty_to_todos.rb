class AddDifficultyToTodos < ActiveRecord::Migration
  def change
  	add_column :todos, :difficulty, :integer
  end
end
