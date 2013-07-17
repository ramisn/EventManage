class Photo < ActiveRecord::Base
  attr_accessible :image, :event_id, :title

  belongs_to :event
  validates_presence_of :title,:event_id
  validates :image, :attachment_presence => true

  has_attached_file :image, :styles => { :full => "576x324", :thumb => "100x100#" }, :default_url => "missing.jpg"
end
