class Todo < ActiveRecord::Base
  attr_accessible :assignedDate, :dueDate, :entry, :priority

  validates :assignedDate, :presence => true
  validates :entry, :presence => true,
  					:length => { :minimum => 4}
end
