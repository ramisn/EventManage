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
      flash[:success] = "Photo added"
      redirect_to admin_photos_path
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
      flash[:success] = "Photo updated!"
     redirect_to admin_photos_path
    else
      render 'edit'
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    if @photo.destroy
      flash[:success] = "photo was removed"
      redirect_to admin_photos_path
    else
      flash[:error] = "failed to remove photo"
      redirect_to admin_photos_path
    end
  end

  def event_photos
    @event = Event.find_by_title(params[:event])
    @photos = @event.photos
  end
end
