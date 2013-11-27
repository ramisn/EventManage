class Admin::MatchesController < AdminController
  add_breadcrumb "Home", :admin_path
  add_breadcrumb "Events", :admin_events_path

  def index
    @event = Event.find(params[:event_id])
    add_breadcrumb "#{@event.title.capitalize}"
    add_breadcrumb "Matches", :admin_event_matches_path
    @matches = @event.matches.order('updated_at desc')
    @teams = []
    @matches.each do |match|
      @teams << Team.where("id IN (?)", [match.t1,match.t2])
    end
  end

  def new
    @event = Event.find(params[:event_id])
    add_breadcrumb "#{@event.title.capitalize}"
    add_breadcrumb "Matches", :admin_event_matches_path
    add_breadcrumb "New"
    @teams = @event.teams
    if( @teams.size >= 2 )
      @match = @event.matches.new
    else
      flash[:error] = "Create atleast Two Teams First to set Match"
      redirect_to new_admin_event_team_path(params[:event_id])
    end
  end

  def create
    @event = Event.find(params[:event_id])
    add_breadcrumb "#{@event.title.capitalize}"
    add_breadcrumb "Matches", :admin_event_matches_path
    add_breadcrumb "New"
    @teams = @event.teams
    @match = @event.matches.new(params[:match])

    if @match.save
      flash[:success] = "Match created!"
      redirect_to admin_event_matches_path
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:event_id])
    @teams = @event.teams
    @match = Match.find(params[:id])
    add_breadcrumb "#{@event.title.capitalize}"
    add_breadcrumb "Matches", :admin_event_matches_path
    add_breadcrumb "#{@match.title.capitalize}"
  end

  def update
    @event = Event.find(params[:event_id])
    @teams = @event.teams
    @match = Match.find(params[:id])
    add_breadcrumb "#{@event.title.capitalize}"
    add_breadcrumb "Matches", :admin_event_matches_path
    add_breadcrumb "#{@match.title.capitalize}"

    if @match.update_attributes(params[:match])
      flash[:success] = "Match updated!"
      redirect_to admin_event_matches_path(params[:event_id])
    else
      render 'edit'
    end
  end

  def destroy
    @match = Match.find(params[:id])
    @match.destroy
    flash[:success] = "Match Deleted"
    redirect_to admin_event_matches_path
  end

  def show
    @event = Event.find(params[:event_id])
    @match = Match.find(params[:id])
    @teams = Team.where("ID IN (?)", [@match.t1,@match.t2])
    add_breadcrumb "#{@event.title.capitalize}"
    add_breadcrumb "Matches", :admin_event_matches_path
    add_breadcrumb "#{@match.title.capitalize}"
  end

  def reset_matches
    @event = Event.find(params[:event_id])
    begin
      @event.matches.clear
      flash[:success] = "Matches Reset!"
      redirect_to admin_event_matches_path
    rescue
      flash[:error] = "Matches reset failed!"
      redirect_to admin_event_matches_path
    end
  end

end
