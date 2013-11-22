class Admin::TeamsController < AdminController
  add_breadcrumb "home", :admin_path
  add_breadcrumb "events", :admin_events_path

  def index
    @event = Event.find(params[:event_id])
    add_breadcrumb "#{@event.title}"
    add_breadcrumb "teams", :admin_event_teams_path
    @users = User.all
    @teams = @event.teams.includes(:players)

    if @event.title == "Cricket"
      @selected_users = User.joins(:team_users).where(team_users: {event_id: params[:event_id]})

      #@dropdown_users = User.where("id NOT IN (?)", @selected_users)
      @dropdown_users = @users - @selected_users
    else
      @dropdown_users = @users
    end
  end

  def new
    @event = Event.find(params[:event_id])
    add_breadcrumb "#{@event.title}"
    add_breadcrumb "teams", :admin_event_teams_path
    add_breadcrumb "new"
    @team = @event.teams.new
  end

  def create
    @event = Event.find(params[:event_id])
    add_breadcrumb "#{@event.title}"
    add_breadcrumb "teams", :admin_event_teams_path
    add_breadcrumb "new"

    @team = @event.teams.new(params[:team])
    if @team.save
      @team.create_result
      flash[:success] = "Team & Result created!"
      redirect_to admin_event_teams_path
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:event_id])
    @team = Team.find(params[:id])
    add_breadcrumb "#{@event.title}"
    add_breadcrumb "teams", :admin_event_teams_path
    add_breadcrumb "#{@team.title}"
  end

  def update
    @event = Event.find(params[:event_id])
    @team = Team.find(params[:id])
    add_breadcrumb "#{@event.title}"
    add_breadcrumb "teams", :admin_event_teams_path
    add_breadcrumb "#{@team.title}"

    if @team.update_attributes(params[:team])
      flash[:success] = "Team updated!"
      redirect_to admin_event_teams_path
    else
      render 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    @team = @event.teams.where(:id=> params[:id]).first
    begin
      @team.destroy
      @team.players.clear
      flash[:success] = "Team Deleted!"
      redirect_to admin_event_teams_path
    rescue
      flash[:error] = "Failed to delete Team"
      redirect_to admin_event_teams_path
    end

  end

  def add_player
    begin
      TeamUser.create!(:team_id=>params[:team_id].to_s,:user_id=>params[:user_id].to_s,:event_id=>params[:event_id].to_s)
      flash[:success] = "Player Added!"
      redirect_to admin_event_teams_path
    rescue
      flash[:error] = "failed to add player."
      redirect_to admin_event_teams_path
    end
  end

  def remove_player
    @player = User.find(params[:user_id])
    @team = Team.find(params[:team_id])
    begin
      @team.players.delete(@player)
      flash[:success] = "Player removed!"
      redirect_to admin_event_teams_path
    rescue
      flash[:error] = "failed to remove player."
      redirect_to admin_event_teams_path
    end
  end

  def reset_team
    @team = Team.find(params[:team_id])
    begin
      @team.players.clear
      flash[:success] = "Team Reset!"
      redirect_to admin_event_teams_path
    rescue
      flash[:error] = "Team reset failed!"
      redirect_to admin_event_teams_path
    end
  end
end
