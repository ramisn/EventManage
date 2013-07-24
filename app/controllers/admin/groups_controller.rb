class Admin::GroupsController < AdminController
  add_breadcrumb "home", :admin_path
  add_breadcrumb "events", :admin_events_path

  def index
    @event = Event.find(params[:event_id])
    add_breadcrumb "#{@event.title}"
    add_breadcrumb "groups", :admin_event_groups_path
    @groups = @event.groups
    @teams = @event.teams.where(:group_id => nil)
  end

  def new
    @event = Event.find(params[:event_id])
    add_breadcrumb "#{@event.title}"
    add_breadcrumb "groups", :admin_event_groups_path
    add_breadcrumb "new"
    @group = @event.groups.new
  end

  def create
    @event = Event.find(params[:event_id])
    add_breadcrumb "#{@event.title}"
    add_breadcrumb "groups", :admin_event_groups_path
    add_breadcrumb "new"

    @group = @event.groups.new(params[:group])
    if @group.save
      flash[:success] = "Group created!"
      redirect_to admin_event_groups_path
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:event_id]) #To show path from admin layout
    @group = Group.find(params[:id])
    add_breadcrumb "#{@event.title}"
    add_breadcrumb "groups", :admin_event_groups_path
    add_breadcrumb "#{@group.title}"
  end

  def update
    @event = Event.find(params[:event_id]) #To show path from admin layout
    @group = Group.find(params[:id])
    add_breadcrumb "#{@event.title}"
    add_breadcrumb "groups", :admin_event_groups_path
    add_breadcrumb "#{@group.title}"

    if @group.update_attributes(params[:group])
      flash[:success] = "Group updated!"
     redirect_to admin_event_groups_path
    else
      render 'edit'
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    @group.teams.clear
    flash[:success] = "Group Deleted!"
    redirect_to admin_event_groups_path
  end

  def add_team
    @group = Group.find(params[:group_id])
    @team = Team.find(params[:team_id])
    if @team.group_id.nil?
      @group.teams << @team
      flash[:success] = "Team Added!"
      redirect_to admin_event_groups_path
    else
      flash[:error] = "failed to add team."
      redirect_to admin_event_groups_path
    end
  end

  def remove_team
    @team = Team.find(params[:team_id])
    begin
      @team.update_attributes(:group_id => nil)
      flash[:success] = "Team removed!"
      redirect_to admin_event_groups_path
    rescue
      flash[:error] = "failed to add team."
      redirect_to admin_event_groups_path
    end
  end

  def reset_group
    @group = Group.find(params[:group_id])
    begin
      @group.teams.clear
      flash[:success] = "Group Reset!"
      redirect_to admin_event_groups_path
    rescue
      flash[:error] = "Group reset failed!"
      redirect_to admin_event_groups_path
    end
  end
end
