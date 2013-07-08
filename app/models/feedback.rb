class Feedback < ActiveRecord::Base
  attr_accessible :email, :feedback, :name

  validates_presence_of :feedback, :email
end
