class PhotosController < ApplicationController
  add_breadcrumb "home", :root_path
  add_breadcrumb "photos", :photos_path

  def index
  end

  def photos
    
    @event = Event.find_by_title(params[:event])
    add_breadcrumb "#{@event.title}"
    add_breadcrumb "thumbnails"
    @photos = @event.photos
  end
end
