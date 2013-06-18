class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  private

  def not_authenticated
    redirect_to login_url, :notice => "Sign in first!"
  end

  def record_not_found
    render 'public/404'
  end
end
