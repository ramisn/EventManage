class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def not_authenticated
    redirect_to login_url, :notice => "First Sign in to view secret page!"
  end
end
