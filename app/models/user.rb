class User < ActiveRecord::Base
  attr_accessible :email, :password, :username

  has_many :todo, :dependent => :destroy

  validates :username, :presence => true
  validates :password, :presence => true
  validates :email, :presence => true
end
