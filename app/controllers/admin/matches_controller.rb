class Admin::MatchesController < ApplicationController
  before_filter :require_login

  def index
    @event = Event.find(params[:event_id])
    @matches = @event.matches.order(:title)
  end

  def new
    @match = Match.new
    @teams = Event.find(params[:event_id]).teams
  end

  def create
    @teams = Event.find(params[:event_id]).teams
    @match = Match.new(params[:match])
    @match.event_id = params[:event_id]

    if @match.save
      redirect_to admin_event_matches_path, :notice => "Match created!"
    else
      render :new
    end
  end

  def edit
    @match = Match.find(params[:id])
    @teams = Event.find(params[:event_id]).teams
  end

  def update
    @teams = Event.find(params[:event_id]).teams
    @match = Match.find(params[:id])
    if @match.update_attributes(params[:match])
     redirect_to admin_event_matches_path, :notice => "Match updated!"
    else
      render 'edit'
    end
  end

  def destroy
    @match = Match.find(params[:id])
    @match.destroy
    redirect_to admin_event_matches_path, :notice => "Match Deleted"
  end

  def reset_matches
    @event = Event.find(params[:event_id])
    begin
      @event.matches.clear
      redirect_to admin_event_matches_path, :notice => "Matches Reset!"
    rescue
      redirect_to admin_event_matches_path, :notice => "Matches reset failed!"
    end
  end

  def update_result
    @match = Match.find(params[:match_id])
    @match.result = params[:result].to_s

    if @match.save
      redirect_to admin_event_matches_path, :notice => "Result Updated!"
    else
      redirect_to admin_event_matches_path, :notice => "Failed to update result!"
    end
  end
end
