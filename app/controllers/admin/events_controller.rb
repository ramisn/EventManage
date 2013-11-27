class Admin::EventsController < AdminController
  add_breadcrumb "Home", :admin_path
  add_breadcrumb "Events", :admin_events_path

  def index
    @events = Event.all
  end

  def new
    add_breadcrumb "New"
    @event = Event.new
  end

  def create
    add_breadcrumb "New"
    @event = Event.new(params[:event])
    if @event.save
      flash[:success] = "Event created!"
      redirect_to admin_events_url
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
    add_breadcrumb "#{@event.title.capitalize}"
  end

  def update
    @event = Event.find(params[:id])
    add_breadcrumb "#{@event.title.capitalize}"

    if @event.update_attributes(params[:event])
      flash[:success] = "Event Updated"
      redirect_to admin_events_path(params[:event_id])
    else
      render 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    TeamUser.where(:event_id => @event.id).delete_all
    @event.destroy
    flash[:success] = "Event Deleted"
    redirect_to admin_events_path
  end

end
