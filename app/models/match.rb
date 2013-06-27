class Match < ActiveRecord::Base
  attr_accessible :title, :description, :t1, :t1_desc, :t2, :t2_desc, :result, :event_id

  validates :title, :t1, :t2,:event_id,:presence => true
  belongs_to :event

  validate :cannot_add_same_team

  def cannot_add_same_team
    errors[:base] << "You cannot add identical teams." if self.t1 == self.t2 || self.t1_desc == self.t2_desc
  end
end
