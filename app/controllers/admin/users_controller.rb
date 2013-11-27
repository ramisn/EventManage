class Admin::UsersController < AdminController
  add_breadcrumb "Home", :admin_path
  add_breadcrumb "Users", :admin_users_path

  def index
    @players = User.all
    @admin_users  = @players.collect {|u| u if u.role.eql?('admin') }.reject {|u| u.nil? }
  end

  def new
    add_breadcrumb "New"
    @user = User.new
  end

  def create
    add_breadcrumb "New"
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
    add_breadcrumb "#{@user.name.capitalize}"
  end

  def update
    @user = User.find(params[:id])
    add_breadcrumb "#{@user.name.capitalize}"

    if @user.update_attributes(params[:user])
      flash[:success] = "User Updated!"
      redirect_to admin_users_path
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    begin
      @user.destroy
      @user.teams.clear
      flash[:success] = "User Deleted!"
      redirect_to admin_users_path
    rescue
      flash[:error] = "Failed to delete User"
      redirect_to admin_users_path
    end
  end
end
