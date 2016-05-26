class DashboardController  < InheritedResources::Base
  # Authorization
  load_and_authorize_resource :rating

  def index
    @events_to_rate = Event.attended_by(current_user).passed.unrated
  end
end
