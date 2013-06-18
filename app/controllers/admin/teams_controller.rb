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
      Result.create!(:team_id => @team.id.to_s)
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
    redirect_to admin_event_teams_path, :notice => "Team Deleted!"
  end

  def add_player
    begin
      TeamUser.create!(:team_id=>params[:team_id].to_s,:user_id=>params[:user_id].to_s,:event_id=>params[:event_id].to_s)
      redirect_to admin_event_teams_path, :notice => "Player Added!"
    rescue
      redirect_to admin_event_teams_path, :notice => "failed to add player."
    end
  end

  def remove_player
    @player = User.find(params[:user_id])
    @team = Team.find(params[:team_id])
    begin
      @team.players.delete(@player)
      redirect_to admin_event_teams_path, :notice => "Player removed!"
    rescue
      redirect_to admin_event_teams_path, :notice => "failed to add player."
    end
  end

  def reset_team
    @team = Team.find(params[:team_id])
    begin
      @team.players.clear
      redirect_to admin_event_teams_path, :notice => "Team Reset!"
    rescue
      redirect_to admin_event_teams_path, :notice => "Team reset failed!"
    end
  end

  def show_result
    @team_result = Team.find(params[:team_id]).result
    if @team_result.nil?
      Result.create!(:team_id => params[:team_id].to_s)
      @team_result = Team.find(params[:team_id]).result
    end
  end

  def plus_one_played
    @team_result = Team.find(params[:team_id]).result
    if(@team_result.played - @team_result.won - @team_result.lost - @team_result.tie - @team_result.nr ) < 1
      @team_result.played += 1
      @team_result.save
      redirect_to team_result_path
    else
      redirect_to team_result_path, :notice => "Sorry! Wrong Entry!"
    end
  end

  def plus_one_won
    @team_result = Team.find(params[:team_id]).result
    if @team_result.played > @team_result.won + @team_result.lost + @team_result.tie + @team_result.nr
      @team_result.won += 1
      @team_result.points += 2
      @team_result.save
      redirect_to team_result_path
    else
      redirect_to team_result_path, :notice => "Sorry! Wrong Entry!"
    end
  end

  def plus_one_lost
    @team_result = Team.find(params[:team_id]).result
    if @team_result.played > @team_result.won + @team_result.lost + @team_result.tie + @team_result.nr
      @team_result.lost += 1
      @team_result.save
      redirect_to team_result_path
    else
      redirect_to team_result_path, :notice => "Sorry! Wrong Entry!"
    end
  end

  def plus_one_tie
    @team_result = Team.find(params[:team_id]).result
    if @team_result.played > @team_result.won + @team_result.lost + @team_result.tie + @team_result.nr
      @team_result.tie += 1
      @team_result.save
      redirect_to team_result_path
    else
      redirect_to team_result_path, :notice => "Sorry! Wrong Entry!"
    end
  end

  def plus_one_nr
    @team_result = Team.find(params[:team_id]).result
    if @team_result.played > @team_result.won + @team_result.lost + @team_result.tie + @team_result.nr
      @team_result.nr += 1
      @team_result.save
      redirect_to team_result_path
    else
      redirect_to team_result_path, :notice => "Sorry! Wrong Entry!"
    end
  end

  def reset_result
    @team = Team.find(params[:team_id])
    begin
      @team.result.delete
      redirect_to team_result_path, :notice => "Result Reset!"
    rescue
      redirect_to team_result_path, :notice => "Result reset failed!"
    end
  end
end
