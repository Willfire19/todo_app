class Todo < ActiveRecord::Base
  attr_accessible :assignedDate, :dueDate, :entry, :priority, :user_id

  belongs_to :user

  validates :assignedDate, :presence => true
  validates :entry, :presence => true,
  					:length => { :minimum => 4}
  validates :user_id, :presence => true
end
