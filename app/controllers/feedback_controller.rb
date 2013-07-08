class FeedbackController < ApplicationController
  def create
    @feedback = Feedback.new(params[:feedback])
    respond_to do |format|
      if @feedback.save
        format.html { redirect_to root_path }
      else
        format.html { redirect_to root_path }
      end
    end
  end
end
