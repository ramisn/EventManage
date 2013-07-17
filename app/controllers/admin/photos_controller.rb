class Admin::PhotosController < AdminController
  def index
    @events = Event.all
  end

  def new
    @events =Event.all
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(params[:photo])
    if @photo.save
      redirect_to admin_photos_path, :notice => "Photo added"
    else
      render :new
    end
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update_attributes(params[:photo])
     redirect_to admin_photos_path, :notice => "Photo updated!"
    else
      render 'edit'
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    if @photo.destroy
      redirect_to admin_photos_path, :notice => "photo was removed"
    else
      redirect_to admin_photos_path, :notice => "failed to remove photo"
    end
  end

  def event_photos
    @event = Event.find_by_title(params[:event])
    @photos = @event.photos
  end
end
