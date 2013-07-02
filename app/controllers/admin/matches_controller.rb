class Admin::MatchesController < AdminController
  def index
    @event = Event.find(params[:event_id])
    @matches = @event.matches.order(:title)
  end

  def new
    @event = Event.find(params[:event_id])
    @teams = @event.teams
    if( @teams.size >= 2 )
      @match = @event.matches.new
    else
      redirect_to new_admin_event_team_path(params[:event_id]), :notice => "Create atlest Two Teams First to set Match"
    end
  end

  def create
    @event = Event.find(params[:event_id])
    @teams = @event.teams
    @match = @event.matches.new(params[:match])

    if @match.save
      redirect_to admin_event_matches_path, :notice => "Match created!"
    else
      render :new
    end
  end

  def edit
    @teams = Event.find(params[:event_id]).teams
    @match = Match.find(params[:id])
  end

  def update
    @teams = Event.find(params[:event_id]).teams
    @match = Match.find(params[:id])
    if @match.update_attributes(params[:match])
     redirect_to admin_event_matches_path(params[:event_id]), :notice => "Match updated!"
    else
      render 'edit'
    end
  end

  def destroy
    @match = Match.find(params[:id])
    @match.destroy
    redirect_to admin_event_matches_path, :notice => "Match Deleted"
  end

  def show
    @event = Event.find(params[:event_id])
    @matches = @event.matches.order(:title)
    @team_result_holder = {}
    @matches.each do |match|
      @team_one_result = @event.teams.where(:title => match.t1).first.result
      @team_two_result = @event.teams.where(:title => match.t2).first.result
      @team_result_holder["#{match.id}"] = [@team_one_result,@team_two_result]
    end
    @match = @matches.find(params[:id])
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

  def match_team_result
    @result = Team.find(params[:team_id]).result
    if params[:result_action] == "played"
      if(@result.played - @result.won - @result.lost - @result.tie - @result.nr ) < 1
        @result.played += 1
        @result.save
        redirect_to admin_event_match_path(params[:event_id],params[:match_id])
      else
        redirect_to admin_event_match_path(params[:event_id],params[:match_id]), :notice => "Sorry! Wrong Entry!"
      end
    elsif params[:result_action] == "won"
      if @result.played > @result.won + @result.lost + @result.tie + @result.nr
        @result.won += 1
        @result.points += 2
        @result.save
        redirect_to admin_event_match_path(params[:event_id],params[:match_id])
      else
        redirect_to admin_event_match_path(params[:event_id],params[:match_id]), :notice => "Sorry! Wrong Entry!"
      end
    elsif params[:result_action] == "lost"
      if @result.played > @result.won + @result.lost + @result.tie + @result.nr
        @result.lost += 1
        @result.save
        redirect_to admin_event_match_path(params[:event_id],params[:match_id])
      else
        redirect_to admin_event_match_path(params[:event_id],params[:match_id]), :notice => "Sorry! Wrong Entry!"
      end
    elsif params[:result_action] == "tie"
      if @result.played > @result.won + @result.lost + @result.tie + @result.nr
        @result.tie += 1
        @result.save
        redirect_to admin_event_match_path(params[:event_id],params[:match_id])
      else
        redirect_to admin_event_match_path(params[:event_id],params[:match_id]), :notice => "Sorry! Wrong Entry!"
      end
    elsif params[:result_action] == "nr"
      if @result.played > @result.won + @result.lost + @result.tie + @result.nr
        @result.nr += 1
        @result.save
        redirect_to admin_event_match_path(params[:event_id],params[:match_id])
      else
        redirect_to admin_event_match_path(params[:event_id],params[:match_id]), :notice => "Sorry! Wrong Entry!"
      end
    else
      redirect_to admin_event_match_path(params[:event_id],params[:match_id]), :notice => 'sorry!'
    end
  end

  def reset_result
    @team = Team.find(params[:team_id])
    begin
      @team.result.update_attributes(:played=>0,:won=>0,:lost=>0,:tie=>0,:nr=>0,:points=>0)
      redirect_to admin_event_match_path(params[:event_id],params[:match_id]), :notice => "Result Reset!"
    rescue
      redirect_to admin_event_match_path(params[:event_id],params[:match_id]), :notice => "Result reset failed!"
    end
  end
end
