class Admin::GroupsController < AdminController
  def index
    @event = Event.find(params[:event_id])
    @groups = @event.groups
    @teams = @event.teams.where(:group_id => nil)
  end

  def new
    @event = Event.find(params[:event_id])
    @group = @event.groups.new
  end

  def create
    @event = Event.find(params[:event_id])
    @group = @event.groups.new(params[:group])
    if @group.save
      redirect_to admin_event_groups_path, :notice => "Group created!"
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(params[:group])
     redirect_to admin_event_groups_path, :notice => "Group updated!"
    else
      render 'edit'
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to admin_event_groups_path, :notice => "Group Deleted!"
  end

  def add_team
    @group = Group.find(params[:group_id])
    @team = Team.find(params[:team_id])
    if @team.group_id.nil?
      @group.teams << @team
      redirect_to admin_event_groups_path, :notice => "Team Added!"
    else
      redirect_to admin_event_groups_path, :notice => "failed to add team."
    end
  end

  def remove_team
    @team = Team.find(params[:team_id])
    begin
      @team.update_attributes(:group_id => nil)
      redirect_to admin_event_groups_path, :notice => "Team removed!"
    rescue
      redirect_to admin_event_groups_path, :notice => "failed to add team."
    end
  end

  def reset_group
    @group = Group.find(params[:group_id])
    begin
      @group.teams.clear
      redirect_to admin_event_groups_path, :notice => "Group Reset!"
    rescue
      redirect_to admin_event_groups_path, :notice => "Group reset failed!"
    end
  end
end
