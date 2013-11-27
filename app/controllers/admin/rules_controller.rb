class Admin::RulesController < AdminController
  add_breadcrumb "Home", :admin_path
  add_breadcrumb "Events", :admin_events_path

  def index
    @event = Event.find(params[:event_id])
    add_breadcrumb "#{@event.title.capitalize}"
    add_breadcrumb "Rules", :admin_event_rules_path

    @rules = @event.rules
  end

  def new
    @event = Event.find(params[:event_id])
    add_breadcrumb "#{@event.title.capitalize}"
    add_breadcrumb "Rules", :admin_event_rules_path
    add_breadcrumb "New"
    @rule = @event.rules.new
  end

  def create
    @event = Event.find(params[:event_id])
    add_breadcrumb "#{@event.title.capitalize}"
    add_breadcrumb "Rules", :admin_event_rules_path
    add_breadcrumb "New"

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
    add_breadcrumb "#{@event.title.capitalize}"
    add_breadcrumb "Rules", :admin_event_rules_path
  end

  def update
    @event = Event.find(params[:event_id])
    @rule = Rule.find(params[:id])
    add_breadcrumb "#{@event.title.capitalize}"
    add_breadcrumb "Rules", :admin_event_rules_path

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
