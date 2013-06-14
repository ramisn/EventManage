class TeamUser < ActiveRecord::Base

  belongs_to :team
  belongs_to :user

  attr_accessible :team_id, :user_id, :event_id

  validates :user_id, :uniqueness => {:scope => :event_id}

end
