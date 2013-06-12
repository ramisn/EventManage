class SessionsController < ApplicationController
  def new
  end

  def create
    user = login(params[:email], params[:password], params[:remember_me])

    if user
      if user.role == 'admin'
        redirect_back_or_to admin_url, :notice => "Signed in"
      else
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
