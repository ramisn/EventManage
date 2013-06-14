class Team < ActiveRecord::Base
  attr_accessible :title,:description, :event_id
  belongs_to :event
  has_many :team_users
  has_many :players, :class_name => 'User', :through => :team_users, :source => :user

  validates :title, :presence => true, :uniqueness => true
  validates :description, :presence => true, :uniqueness => true
end
