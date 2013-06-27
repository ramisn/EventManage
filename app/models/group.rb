class Group < ActiveRecord::Base
  attr_accessible :title, :event_id

  belongs_to :event
  has_many :teams

  validates :title, :presence => true, :uniqueness => {:scope => :event_id}
end
