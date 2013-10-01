class Photo < ActiveRecord::Base
  attr_accessible :image, :event_id, :title

  belongs_to :event
  validates_presence_of :title,:event_id
  #validates :image, :attachment_presence => true,
  validates_attachment :image, :presence => true, :content_type => { :content_type => /^image\/(png|gif|jpeg)/ }, :size => { :in => 0..2000.kilobytes }

  has_attached_file :image, :styles => { :full => "944x600#", :thumb => "100x100#", :heroimage => "944x295#" }, :default_url => "missing.jpg"
end
