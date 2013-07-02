class Admin::TeamsController < AdminController
  def index
    @event = Event.find(params[:event_id])
    @teams = @event.teams
    @users = User.all
  end

  def new
    @event = Event.find(params[:event_id])
    @team = @event.teams.new
  end

  def create
    @event = Event.find(params[:event_id])
    @team = @event.teams.new(params[:team])
    if @team.save
      @team.create_result
      redirect_to admin_event_teams_path, :notice => "Team & Result created!"
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
end
