class HomeController < ApplicationController
  add_breadcrumb "Home", :root_path

  def index
    @events = Event.all
    @photos = Photo.all
    #Logic-1 :: It is faster than Logic-2 in data load.
    @matches = Match.order("updated_at DESC")

    @match_results = []
    @match_fixtures = []
    @matches.collect { |m| @match_results << m unless m.result.eql?('nil') }
    @matches.collect { |m| @match_fixtures << m if m.result.eql?('nil') }

    @teams_for_results = []
    @teams_for_fixtures = []

    @match_results.each do |match|
      @teams_for_results << Team.where("id IN (?)", [match.t1,match.t2])
    end

    @match_fixtures.each do |match|
      @teams_for_fixtures << Team.where("id IN (?)", [match.t1,match.t2])
    end


    #End-Of-Logic-1#

    #render :text => @match_results and return false
    # Logic-2 :: It seems easy in coding but through it, data load is more than Logic-1.
=begin
    @match_results = []
    @match_fixtures = []
    @events.each do |event|
      @match_results << event.matches.result_not_nil
      @teams_for_results = []
      @match_results.each do |match_result|
        match_result.each do |match|
          @teams_for_results << Team.where("id IN (?)", [match.t1,match.t2])
        end
      end

      @match_fixtures << event.matches.where(:result => "nil")
      @teams_for_fixtures = []
      @match_fixtures.each do |match_fixture|
        match_fixture.each do |match|
          @teams_for_fixtures << Team.where("id IN (?)", [match.t1,match.t2])
        end
      end
    end
=end
  end
end
