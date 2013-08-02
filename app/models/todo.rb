class Todo < ActiveRecord::Base
  after_initialize :assign_defaults_on_new_Todo, if: 'new_record?'

  attr_accessible :assignedDate, :dueDate, :entry, :priority, 
                  :status, :difficulty, :tag

  belongs_to :user

  validates :assignedDate, :presence => true
  validates :entry, :presence => true,
  					:length => { :minimum => 4 },
  					:length => { :maximum => 256 }
  validates :user_id, :presence => true
  validates :status, :presence => true
  validates :difficulty, :presence => true, :inclusion => 1..100
  validates :priority, :inclusion => 1..11

  default_scope order: 'todos.created_at DESC'

  # Returns todos from the users being followed by the given user.
  def self.from_users_followed_by(user)
  	followed_user_ids = "SELECT followed_id FROM relationships
  											WHERE follower_id = :user_id"
  	where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
  	user_id: user)
  end

  private

  def assign_defaults_on_new_Todo
    self.status = "To Do"
  end
end
