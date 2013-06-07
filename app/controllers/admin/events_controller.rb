class Admin::EventsController < ApplicationController
  before_filter :require_login

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      redirect_to admin_url, :notice => "Event created!"
    else
      render :new
    end
  end

  def index
    @event = Event.all
  end

end
