class PhotosController < ApplicationController
  def index
    @events = Event.all
  end

  def photos
    @event = Event.find_by_title(params[:event])
    @photos = @event.photos
  end
end
