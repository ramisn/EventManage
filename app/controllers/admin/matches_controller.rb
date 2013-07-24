class Admin::MatchesController < AdminController
  add_breadcrumb "home", :admin_path
  add_breadcrumb "events", :admin_events_path

  def index
    @event = Event.find(params[:event_id])
    add_breadcrumb "#{@event.title}"
    add_breadcrumb "matches", :admin_event_matches_path
    @matches = @event.matches.order(:title)
    @team_1 = []
    @team_2 = []
    @matches.each do |match|
      @team_1 << Team.find(match.t1)
      @team_2 << Team.find(match.t2)
    end
  end

  def new
    @event = Event.find(params[:event_id])
    add_breadcrumb "#{@event.title}"
    add_breadcrumb "matches", :admin_event_matches_path
    add_breadcrumb "new"
    @teams = @event.teams
    if( @teams.size >= 2 )
      @match = @event.matches.new
    else
      flash[:error] = "Create atlest Two Teams First to set Match"
      redirect_to new_admin_event_team_path(params[:event_id])
    end
  end

  def create
    @event = Event.find(params[:event_id])
    add_breadcrumb "#{@event.title}"
    add_breadcrumb "matches", :admin_event_matches_path
    add_breadcrumb "new"
    @teams = @event.teams
    @match = @event.matches.new(params[:match])

    if @match.save
      flash[:success] = "Match created!"
      redirect_to admin_event_matches_path
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:event_id])
    @teams = @event.teams
    @match = Match.find(params[:id])
    add_breadcrumb "#{@event.title}"
    add_breadcrumb "matches", :admin_event_matches_path
    add_breadcrumb "#{@match.title}"
  end

  def update
    @event = Event.find(params[:event_id])
    @teams = @event.teams
    @match = Match.find(params[:id])
    add_breadcrumb "#{@event.title}"
    add_breadcrumb "matches", :admin_event_matches_path
    add_breadcrumb "#{@match.title}"

    if @match.update_attributes(params[:match])
      flash[:success] = "Match updated!"
      redirect_to admin_event_matches_path(params[:event_id])
    else
      render 'edit'
    end
  end

  def destroy
    @match = Match.find(params[:id])
    @match.destroy
    flash[:success] = "Match Deleted"
    redirect_to admin_event_matches_path
  end

  def show
    @event = Event.find(params[:event_id])
    @matches = @event.matches.order(:title)
    @team_result_holder = {}
    @matches.each do |match|
      @team_one = @event.teams.where(:id => match.t1).first
      @team_two = @event.teams.where(:id => match.t2).first
      unless @team_one.nil? || @team_two.nil?
        @team_one_result = @team_one.result
        @team_two_result = @team_two.result
        @team_result_holder["#{match.id}"] = [@team_one_result,@team_two_result]
      else
        flash[:error] = "No result found! It may happen that one of the Team doesn't exist. Please Remove that match and create again"
        redirect_to admin_event_matches_path
      end
    end
    @match = @matches.find(params[:id])
    add_breadcrumb "#{@event.title}"
    add_breadcrumb "matches", :admin_event_matches_path
    add_breadcrumb "#{@match.title}"

    @team_1 = []
    @team_2 = []
    @team_1 << Team.find(@match.t1)
    @team_2 << Team.find(@match.t2)
  end

  def reset_matches
    @event = Event.find(params[:event_id])
    begin
      @event.matches.clear
      flash[:success] = "Matches Reset!"
      redirect_to admin_event_matches_path
    rescue
      flash[:error] = "Matches reset failed!"
      redirect_to admin_event_matches_path
    end
  end

  def match_team_result
    @result = Team.find(params[:team_id]).result
    if params[:result_action] == "played"
      if(@result.played - @result.won - @result.lost - @result.tie - @result.nr ) < 1
        @result.played += 1
        @result.save
        redirect_to admin_event_match_path(params[:event_id],params[:match_id])
      else
        flash[:error] = "Sorry! Wrong Entry!"
        redirect_to admin_event_match_path(params[:event_id],params[:match_id])
      end
    elsif params[:result_action] == "won"
      if @result.played > @result.won + @result.lost + @result.tie + @result.nr
        @result.won += 1
        @result.points += 2
        @result.save
        redirect_to admin_event_match_path(params[:event_id],params[:match_id])
      else
        flash[:error] = "Sorry! Wrong Entry!"
        redirect_to admin_event_match_path(params[:event_id],params[:match_id])
      end
    elsif params[:result_action] == "lost"
      if @result.played > @result.won + @result.lost + @result.tie + @result.nr
        @result.lost += 1
        @result.save
        redirect_to admin_event_match_path(params[:event_id],params[:match_id])
      else
        flash[:error] = "Sorry! Wrong Entry!"
        redirect_to admin_event_match_path(params[:event_id],params[:match_id])
      end
    elsif params[:result_action] == "tie"
      if @result.played > @result.won + @result.lost + @result.tie + @result.nr
        @result.tie += 1
        @result.save
        redirect_to admin_event_match_path(params[:event_id],params[:match_id])
      else
        flash[:error] = "Sorry! Wrong Entry!"
        redirect_to admin_event_match_path(params[:event_id],params[:match_id])
      end
    elsif params[:result_action] == "nr"
      if @result.played > @result.won + @result.lost + @result.tie + @result.nr
        @result.nr += 1
        @result.save
        redirect_to admin_event_match_path(params[:event_id],params[:match_id])
      else
        flash[:error] = "Sorry! Wrong Entry!"
        redirect_to admin_event_match_path(params[:event_id],params[:match_id])
      end
    else
      flash[:error] = "Sorry! access denied"
      redirect_to admin_event_match_path(params[:event_id],params[:match_id])
    end
  end

  def reset_result
    @team = Team.find(params[:team_id])
    begin
      @team.result.update_attributes(:played=>0,:won=>0,:lost=>0,:tie=>0,:nr=>0,:points=>0)
      flash[:success] = "Result Reset!"
      redirect_to admin_event_match_path(params[:event_id],params[:match_id])
    rescue
      flash[:error] = "Result reset failed!"
      redirect_to admin_event_match_path(params[:event_id],params[:match_id])
    end
  end
end
