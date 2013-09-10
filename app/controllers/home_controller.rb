class HomeController < ApplicationController
  add_breadcrumb "home", :root_path

  def index
    @events = Event.all
    @photos = Photo.all
    #Logic-1 :: It is faster than Logic-2 in data load.
    @matches = Match.all
    @temp1_results = []
    @temp2_fixtures = []
    @matches.collect { |m| @temp1_results << m unless m.result.eql?('nil') }
    @matches.collect { |m| @temp2_fixtures << m if m.result.eql?('nil') }

    @match_results = []
    @match_fixtures = []
    @teams_for_results = []
    @teams_for_fixtures = []
    @events.each do |event|
      temp = []
      @temp1_results.collect {|m| temp << m if m.event_id.eql?(event.id) }
      @match_results << temp

      temp = []
      @temp2_fixtures.collect {|m| temp << m if m.event_id.eql?(event.id) }
      @match_fixtures << temp
    end

    @match_results.each do |match_result|
      match_result.each do |match|
        @teams_for_results << Team.where("id IN (?)", [match.t1,match.t2])
      end
    end

    @match_fixtures.each do |match_fixture|
      match_fixture.each do |match|
        @teams_for_fixtures << Team.where("id IN (?)", [match.t1,match.t2])
      end
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
