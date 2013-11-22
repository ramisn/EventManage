class EventsController < ApplicationController
  add_breadcrumb "home", :root_path
  add_breadcrumb "events", :events_path

  def index
    @events = Event.all
  end

  def matches
    @events = Event.all
    #@event = @events.collect { |e| e if e.id.eql?(params[:id].to_i)}.reject { |e| e.nil? }.first
    @event = Event.find(params[:id])  #improved performance
    add_breadcrumb "#{@event.title}"
    add_breadcrumb "matches"
    @matches = @event.matches.order("updated_at DESC")

    @match_results = []
    @match_fixtures = []
    @matches.collect { |m| @match_results << m unless m.result.eql?('nil') }
    @matches.collect { |m| @match_fixtures << m if m.result.eql?('nil') }

    @teams_for_results = []
    @teams_for_fixtures = []

    @match_results.each do |match|
      @teams_for_results << Team.where("id IN (?)", [match.t1,match.t2])
    end

    @match_fixtures = @match_fixtures.reverse!
    @match_fixtures.each do |match|
      @teams_for_fixtures << Team.where("id IN (?)", [match.t1,match.t2])
    end
  end

  def teams
    @events = Event.all
    #@event = @events.collect { |e| e if e.id.eql?(params[:id].to_i)}.reject { |e| e.nil? }.first
    @event = Event.find(params[:id])  #improved performance
    add_breadcrumb "#{@event.title}"
    add_breadcrumb "teams"
    @teams = @event.teams.includes(:players)
  end

  def groups
    @events = Event.all
    #@event = @events.collect { |e| e if e.id.eql?(params[:id].to_i)}.reject { |e| e.nil? }.first
    @event = Event.find(params[:id])  #improved performance
    add_breadcrumb "#{@event.title}"
    add_breadcrumb "groups"
    @groups = @event.groups.includes(:teams)
  end

  def results
    @events = Event.all
    #@event = @events.collect { |e| e if e.id.eql?(params[:id].to_i)}.reject { |e| e.nil? }.first
    @event = Event.find(params[:id])  #improved performance
    add_breadcrumb "#{@event.title}"
    add_breadcrumb "results"
    @teams = @event.teams.includes(:result)
  end

  def rules
    @events = Event.all
    #@event = @events.collect { |e| e if e.id.eql?(params[:id].to_i)}.reject { |e| e.nil? }.first
    @event = Event.find(params[:id])  #improved performance
    add_breadcrumb "#{@event.title}"
    add_breadcrumb "rules"
    @rules = @event.rules
  end
end
