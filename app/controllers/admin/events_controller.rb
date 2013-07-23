class Admin::EventsController < AdminController
  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      flash[:success] = "Event created!"
      redirect_to admin_events_url
    else
      render :new
    end
  end

  def index
    @events = Event.all
  end

  def show
    redirect_to admin_event_matches_path(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

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
