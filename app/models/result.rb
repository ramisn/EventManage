class Result < ActiveRecord::Base
  attr_accessible :played,:won,:lost,:tie,:nr,:points,:nrr,:team_id

  belongs_to :team
end
