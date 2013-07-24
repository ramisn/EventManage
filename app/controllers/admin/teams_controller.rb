class Admin::TeamsController < AdminController
  add_breadcrumb "home", :admin_path
  add_breadcrumb "events", :admin_events_path

  def index
    @event = Event.find(params[:event_id])
    add_breadcrumb "#{@event.title}"
    add_breadcrumb "teams", :admin_event_teams_path
    @teams = @event.teams
    @users = User.all
    @dropdown_users = []
    @users.each do |user|
      if user.teams.where(:event_id=>params[:event_id]).empty?
        @dropdown_users << user
      end
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
    @team = Team.find(params[:id])
    @team.destroy
    flash[:success] = "Team Deleted!"
    redirect_to admin_event_teams_path
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
      flash[:error] = "failed to add player."
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
