class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event_id = params[:id]
  end

  def teams
    @event = Event.find(params[:id])
    @teams = @event.teams
    @rules = @event.rules
  end

  def results
    @event = Event.find(params[:id])
    @teams = @event.teams
  end

  def matches
    @event = Event.find(params[:id])
    @matches = @event.matches.order(:title)
  end

  def rules
    @event = Event.find(params[:id])
    @rules = @event.rules
  end
end
