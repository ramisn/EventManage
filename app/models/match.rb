class Match < ActiveRecord::Base
  attr_accessible :title, :description, :t1, :t1_desc, :t2, :t2_desc, :result, :event_id

  validates :t1, :t2,:event_id,:presence => true
  validates :title, :presence => true, :uniqueness => {:scope => :event_id}
  belongs_to :event

  validate :cannot_add_same_team

  def cannot_add_same_team
    errors[:base] << "You cannot add identical teams." if self.t1 == self.t2
  end
end
