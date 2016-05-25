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
end
