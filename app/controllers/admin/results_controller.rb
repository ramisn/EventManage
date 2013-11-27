class Admin::ResultsController < AdminController
  add_breadcrumb "Home", :admin_path
  add_breadcrumb "Events", :admin_events_path

  def index
    @event = Event.find(params[:event_id])
    add_breadcrumb "#{@event.title.capitalize}"
    add_breadcrumb "Results", :admin_event_results_path
    @teams = @event.teams.includes(:result)
  end

  def team_result
    @result = Team.find(params[:team_id]).result
    if params[:result_action] == "played"
      if(@result.played - @result.won - @result.lost - @result.tie - @result.nr ) < 1
        @result.played += 1
        @result.save
        redirect_to admin_event_results_path(params[:event_id])
      else
        flash[:error] = "Sorry! Wrong Entry!"
        redirect_to admin_event_results_path(params[:event_id])
      end
    elsif params[:result_action] == "won"
      if @result.played > @result.won + @result.lost + @result.tie + @result.nr
        @result.won += 1
        @result.points += 2
        @result.save
        redirect_to admin_event_results_path(params[:event_id])
      else
        flash[:error] = "Sorry! Wrong Entry!"
        redirect_to admin_event_results_path(params[:event_id])
      end
    elsif params[:result_action] == "lost"
      if @result.played > @result.won + @result.lost + @result.tie + @result.nr
        @result.lost += 1
        @result.save
        redirect_to admin_event_results_path(params[:event_id])
      else
        flash[:error] = "Sorry! Wrong Entry!"
        redirect_to admin_event_results_path(params[:event_id])
      end
    elsif params[:result_action] == "tie"
      if @result.played > @result.won + @result.lost + @result.tie + @result.nr
        @result.tie += 1
        @result.points += 1
        @result.save
        redirect_to admin_event_results_path(params[:event_id])
      else
        flash[:error] = "Sorry! Wrong Entry!"
        redirect_to admin_event_results_path(params[:event_id])
      end
    elsif params[:result_action] == "nr"
      if @result.played > @result.won + @result.lost + @result.tie + @result.nr
        @result.nr += 1
        @result.save
        redirect_to admin_event_results_path(params[:event_id])
      else
        flash[:error] = "Sorry! Wrong Entry!"
        redirect_to admin_event_results_path(params[:event_id])
      end
    else
      flash[:error] = "Sorry! access denied"
      redirect_to admin_event_results_path(params[:event_id])
    end
  end

  def reset_result
    @team = Team.find(params[:team_id])
    begin
      @team.result.update_attributes(:played=>0,:won=>0,:lost=>0,:tie=>0,:nr=>0,:points=>0)
      flash[:success] = "Result Reset!"
      redirect_to admin_event_results_path(params[:event_id])
    rescue
      flash[:error] = "Result reset failed!"
      redirect_to admin_event_results_path(params[:event_id])
    end
  end
end
