class DashboardController  < InheritedResources::Base
  belongs_to :mentor

  # Authorization
  load_and_authorize_resource :rating

  def index
    @events_to_rate = Event.attended_by(current_user).passed.unrated
  end
end
