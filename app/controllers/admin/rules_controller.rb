class Admin::RulesController < AdminController
  def index
    @event = Event.find(params[:event_id])
    @rules = @event.rules
  end

  def new
    @event = Event.find(params[:event_id])
    @rule = @event.rules.new
  end

  def create
    @event = Event.find(params[:event_id])
    @rule = @event.rules.new(params[:rule])

    if @rule.save
      flash[:success] = "Rule created!"
      redirect_to admin_event_rules_path
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:event_id])
    @rule = Rule.find(params[:id])
  end

  def update
    @event = Event.find(params[:event_id])
    @rule = Rule.find(params[:id])
    if @rule.update_attributes(params[:rule])
      flash[:success] = "Rule updated!"
     redirect_to admin_event_rules_path
    else
      render 'edit'
    end
  end

  def destroy
    @rule = Rule.find(params[:id])
    @rule.destroy
    flash[:success] = "Rule Deleted"
    redirect_to admin_event_rules_path
  end
end
