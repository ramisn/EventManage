class EventsController < ApplicationController
  add_breadcrumb "home", :root_path
  add_breadcrumb "events", :events_path

  def index
    @events = Event.all
  end

  def show
    redirect_to matches_event_path
  end

  def matches
    @event = Event.find(params[:id])
    add_breadcrumb "#{@event.title}"
    add_breadcrumb "matches"
    @matches = @event.matches.order(:title)
    @team_1 = []
    @team_2 = []
    @matches.each do |match|
      @team_1 << Team.find(match.t1)
      @team_2 << Team.find(match.t2)
    end
  end

  def teams
    @event = Event.find(params[:id])
    add_breadcrumb "#{@event.title}"
    add_breadcrumb "teams"
    @teams = @event.teams
    @rules = @event.rules
  end

  def groups
    @event = Event.find(params[:id])
    add_breadcrumb "#{@event.title}"
    add_breadcrumb "groups"
    @groups = @event.groups
  end

  def results
    @event = Event.find(params[:id])
    add_breadcrumb "#{@event.title}"
    add_breadcrumb "results"
    @teams = @event.teams.find(:all, :include => :players)
  end

  
  def rules
    @event = Event.find(params[:id])
    add_breadcrumb "#{@event.title}"
    add_breadcrumb "rules"
    @rules = @event.rules
  end
end
