class Event < ActiveRecord::Base
  attr_accessible :title, :description, :venue, :starts_at, :ends_at

  validates :title, :presence => true, :uniqueness => true
  validates :description, :presence => true

  has_many :teams, :dependent => :destroy
end
