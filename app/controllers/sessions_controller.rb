class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to root_url, :notice => "User already Logged in. Logout first!"
    end
  end

  def create
    user = login(params[:email], params[:password], params[:remember_me])

    if user
      if user.role == 'admin'
        flash[:success] = "Signed in"
        redirect_back_or_to admin_url
      else
        logout
        flash.now.alert = "You are not admin. Sorry!"
        render 'new'
      end
    else
      flash.now.alert = "Email/password was invalid"
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to root_url, :notice => "Logged out!"
  end
end
