class HomeController < ApplicationController
  add_breadcrumb "home", :root_path

  def index
    @events = Event.all
    @photos = Photo.all
    @match_results = []
    @match_fixtures = []
    @events.each do |event|
      @match_results << event.matches.result_not_nil

      @match_fixtures << event.matches.where(:result => "nil")
    end
  end
end
