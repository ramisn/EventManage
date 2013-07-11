class Feedback < ActiveRecord::Base
  attr_accessible :email, :feedback, :name

  validates_presence_of :feedback, :email

  def self.search(search)
    if search
      q = "%#{search}%"
      where('name LIKE ? or email LIKE ? ', q, q)
    else
      scoped
    end
  end
end
