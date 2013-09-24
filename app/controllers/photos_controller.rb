class PhotosController < ApplicationController
  add_breadcrumb "home", :root_path
  add_breadcrumb "photos", :photos_path

  def index
    @events = Event.includes(:photos)
  end

  def photos
    @events = Event.all
    @event = @events.collect { |e| e if e.title.eql?(params[:event])}.reject { |e| e.nil? }.first
    add_breadcrumb "#{@event.title}"
    add_breadcrumb "thumbnails"
    @photos = @event.photos
  end
end
