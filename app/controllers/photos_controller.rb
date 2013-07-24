class PhotosController < ApplicationController
  add_breadcrumb "home", :root_path
  add_breadcrumb "photos", :photos_path

  def index
    @events = Event.all
  end

  def photos
    add_breadcrumb "thumbnails"
    @event = Event.find_by_title(params[:event])
    @photos = @event.photos
  end
end
