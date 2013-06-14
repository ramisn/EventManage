class TeamUser < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :team
  belongs_to :user

  # These join attributes should be immutable
  attr_readonly :team_id, :user_id, :event_id

  validates :user_id, :uniqueness => { :scope => :team_id }

end
