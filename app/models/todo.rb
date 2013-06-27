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

  # Returns todos from the users being followed by the given user.
  def self.from_users_followed_by(user)
  	followed_user_ids = "SELECT followed_id FROM relationships
  											WHERE follower_id = :user_id"
  	where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
  	user_id: user)
  end
end
