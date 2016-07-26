class EventsController < CrudController
  def event_params
    permitted_params = params.require(:event)

    permitted_params.permit([
      :summary,
      :description,
      :start_at,
      :end_at,
      :url
    ])
  end

  def update
    update! do |format|
      format.html do
        unless params[:redirect_location].blank?
          redirect_to params[:redirect_location]
        else
          redirect_to collection_url
        end
      end
    end
  end

  def timeline
    @events = Event.add_today(@events)
  end
end
