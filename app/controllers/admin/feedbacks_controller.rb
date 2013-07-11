class Admin::FeedbacksController < AdminController
  helper_method :sort_column, :sort_direction
  def index
    @feedbacks = Feedback.search(params[:search]).order(sort_column + ' ' + sort_direction)
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def sort_column
    Feedback.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

end
