class ExpertSessionsController < EventsController

  defaults resource_class: ExpertSession
  belongs_to :mentor, optional: true

  def new
    resource.prefill(parent)
    new!
  end

  def expert_session_params
    permitted_params = params.require(:expert_session)

    permitted_params.permit([
      :summary,
      :description,
      :start_at,
      :end_at,
      :url,
      :team_id,
      :mentor_id
    ])
  end
end
