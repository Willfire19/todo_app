class Todo < ActiveRecord::Base
  attr_accessible :assignedDate, :dueDate, :entry, :priority
  # other attributes: assignedDate, dueDate, priority, user_id
  belongs_to :user

  validates :assignedDate, :presence => true
  validates :entry, :presence => true,
  					:length => { :minimum => 4 },
  					:length => { :maximum => 140 }
  validates :user_id, :presence => true

  default_scope order: 'todos.created_at DESC'
end
