class Team < ActiveRecord::Base
  attr_accessible :title,:description, :event_id, :group_id

  validates :title, :presence => true, :uniqueness => {:scope => :event_id}

  belongs_to :event

  has_many :team_users
  has_many :players, :through => :team_users, :source => :user

  has_one :result, :dependent => :destroy
  belongs_to :group

end
