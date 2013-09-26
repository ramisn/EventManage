class Event < ActiveRecord::Base
  attr_accessible :title, :description, :venue, :starts_at, :ends_at

  validates :title, :presence => true, :uniqueness => true

  has_many :teams, :dependent => :destroy
  has_many :rules, :dependent => :destroy
  has_many :matches, :dependent => :destroy
  has_many :groups, :dependent => :destroy
  has_many :photos, :dependent => :destroy

  extend FriendlyId
  friendly_id :title, use: :slugged
end
