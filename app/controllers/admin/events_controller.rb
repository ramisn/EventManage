class Admin::EventsController < ApplicationController
  before_filter :require_login

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      redirect_to admin_events_url, :notice => "Event created!"
    else
      render :new
    end
  end

  def index
    @events = Event.all
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update_attributes(params[:event])
      redirect_to admin_events_path(params[:event_id]), :notice => "Event Updated"
    else
      render 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to admin_events_path, :notice => "Event Deleted"
  end

end
