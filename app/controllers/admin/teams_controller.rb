class Admin::TeamsController < ApplicationController
  before_filter :require_login

  def index
    @event = Event.find(params[:event_id])
    @teams = @event.teams
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(params[:team])
    @team.event_id = params[:event_id]

    if @team.save
      redirect_to admin_event_teams_path, :notice => "Team created!"
    else
      render :new, :notice => "error creating!"
    end
  end
end
