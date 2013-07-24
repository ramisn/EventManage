class Admin::RulesController < AdminController
  add_breadcrumb "home", :admin_path
  add_breadcrumb "events", :admin_events_path

  def index
    @event = Event.find(params[:event_id])
    add_breadcrumb "#{@event.title}"
    add_breadcrumb "rules", :admin_event_rules_path

    @rules = @event.rules
  end

  def new
    @event = Event.find(params[:event_id])
    add_breadcrumb "#{@event.title}"
    add_breadcrumb "rules", :admin_event_rules_path
    add_breadcrumb "new"
    @rule = @event.rules.new
  end

  def create
    @event = Event.find(params[:event_id])
    add_breadcrumb "#{@event.title}"
    add_breadcrumb "rules", :admin_event_rules_path
    add_breadcrumb "new"

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
    add_breadcrumb "#{@event.title}"
    add_breadcrumb "rules", :admin_event_rules_path
  end

  def update
    @event = Event.find(params[:event_id])
    @rule = Rule.find(params[:id])
    add_breadcrumb "#{@event.title}"
    add_breadcrumb "rules", :admin_event_rules_path

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
