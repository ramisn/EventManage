class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show_teams
    @event = Event.find(params[:id])
    @teams = @event.teams
    @rules = @event.rules
  end

  def results
    @event = Event.find(params[:id])
    @teams = @event.teams
  end
end
