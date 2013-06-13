class Admin::TeamsController < ApplicationController
  before_filter :require_login

  def index
    @event = Event.find(params[:event_id])
    @teams = @event.teams
    @rules = @event.rules
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
      render :new
    end
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    if @team.update_attributes(params[:team])
     redirect_to admin_event_teams_path, :notice => "Team updated!"
    else
      render 'edit'
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    redirect_to admin_event_teams_path, :notice => "Team Deleted"
  end

  def add_player
    @player = User.find(params[:user_id])
    @team = Team.find(params[:id])
    #render :text=> @team.inspect and return false
    begin 
      @team.players << @player
      redirect_to admin_event_teams_path, :notice => "Player Added !"
    rescue
      redirect_to admin_event_teams_path, :notice => "failed to add player."
    end
  end
end
