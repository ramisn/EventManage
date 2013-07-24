class Admin::UsersController < AdminController
  add_breadcrumb "home", :admin_path
  add_breadcrumb "users", :admin_users_path

  def index
    @admin_users = User.admin_users
    @players = User.all
  end

  def new
    add_breadcrumb "new"
    @user = User.new
  end

  def create
    add_breadcrumb "new"
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Signed up!"
      redirect_to admin_users_url
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    add_breadcrumb "#{@user.name}"
  end

  def update
    @user = User.find(params[:id])
    add_breadcrumb "#{@user.name}"

    if @user.update_attributes(params[:user])
      flash[:success] = "User Updated!"
      redirect_to admin_users_path
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "User Deleted!"
    redirect_to admin_users_path
  end
end
