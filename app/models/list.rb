class List < ActiveRecord::Base
  attr_accessible :name

  belongs_to :user
  has_many :todos, :dependent => :destroy
end
