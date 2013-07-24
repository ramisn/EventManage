class Admin::EventsController < AdminController
  add_breadcrumb "home", :admin_path
  add_breadcrumb "events", :admin_events_path

  def index
    @events = Event.all
  end

  def new
    add_breadcrumb "new"
    @event = Event.new
  end

  def create
    add_breadcrumb "new"
    @event = Event.new(params[:event])
    if @event.save
      flash[:success] = "Event created!"
      redirect_to admin_events_url
    else
      render :new
    end
  end

  def show
    redirect_to admin_event_matches_path(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
    add_breadcrumb "#{@event.title}"
  end

  def update
    @event = Event.find(params[:id])
    add_breadcrumb "#{@event.title}"

    if @event.update_attributes(params[:event])
      flash[:success] = "Event Updated"
      redirect_to admin_events_path(params[:event_id])
    else
      render 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    flash[:success] = "Event Deleted"
    redirect_to admin_events_path
  end

end
