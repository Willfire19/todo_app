class List < ActiveRecord::Base
  attr_accessible :name

  belongs_to :user
  has_many :todos, :dependent => :destroy
  validates :user_id, :presence => true
  validates :name, :presence => true,
  					:length => { :minimum => 4 },
  					:length => { :maximum => 25 }

  # Returns lists from the users being followed by the given user.
  def self.from_users_followed_by(user)
  	followed_user_ids = "SELECT followed_id FROM relationships
  											WHERE follower_id = :user_id"
  	where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
  	user_id: user)
  end
end
