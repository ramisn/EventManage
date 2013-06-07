class Event < ActiveRecord::Base
  attr_accessible :title, :description, :starts_at, :ends_at
end
