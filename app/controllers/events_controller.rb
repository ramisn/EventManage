class EventsController < ApplicationController
  add_breadcrumb "home", :root_path
  add_breadcrumb "events", :events_path

  def index
    @events = Event.all
  end

  def show
    redirect_to matches_event_path
  end

  def teams
    add_breadcrumb "teams"
    @event = Event.find(params[:id])
    @teams = @event.teams
    @rules = @event.rules
  end

  def results
    add_breadcrumb "results"
    @event = Event.find(params[:id])
    @teams = @event.teams
  end

  def matches
    add_breadcrumb "matches"
    @event = Event.find(params[:id])
    @matches = @event.matches.order(:title)
    @team_1 = []
    @team_2 = []
    @matches.each do |match|
      @team_1 << Team.find(match.t1)
      @team_2 << Team.find(match.t2)
    end
  end

  def rules
    add_breadcrumb "rules"
    @event = Event.find(params[:id])
    @rules = @event.rules
  end

  def groups
    add_breadcrumb "groups"
    @event = Event.find(params[:id])
    @groups = @event.groups
  end
end
