class User < ActiveRecord::Base
  after_create :create_new_List

  attr_accessible :email, :username, :password, :password_confirmation
  has_secure_password

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  has_many :lists, :dependent => :destroy
  # has_many :todos, through: :lists #, :dependent => :destroy
  has_many :todos, :dependent => :destroy
  has_many :relationships, foreign_key: "follower_id", :dependent => :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name: "Relationship",
                                   dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  validates :username, :presence => true, length: { maximum: 50 }
  validates :password, :presence => true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => true, 
  			format: { with: VALID_EMAIL_REGEX },
  			uniqueness: { case_sensitive: false }

  def send_password_reset
    create_password_reset_token
    self.password_reset_sent_at = Time.zone.now
    save!(validate: false)
    UserMailer.password_reset(self).deliver
  end

  def feed
    #Todo.from_users_followed_by(self)
    List.from_users_followed_by(self)
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end
  
  private

    def create_password_reset_token
      self.password_reset_token = SecureRandom.urlsafe_base64
    end

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    def create_new_List
      @list = self.lists.build( name: "Uncategorized" )
      @list.save
    end
end