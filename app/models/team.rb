class Team < ActiveRecord::Base
  attr_accessible :title,:description, :event_id
  belongs_to :event
  has_many :team_users
  has_many :users, :through => :team_users

  validates :title, :presence => true, :uniqueness => true
  validates :description, :presence => true, :uniqueness => true
end
