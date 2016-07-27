class MentoringsController < EventsController

  defaults resource_class: Mentoring
  belongs_to :team, optional: true

  def new
    resource.prefill(parent)
    new!
  end

  def mentoring_params
    permitted_params = params.require(:mentoring)

    permitted_params.permit([
      :summary,
      :description,
      :start_at,
      :end_at,
      :location,
      :url,
      :team_id,
      :mentor_id
    ])
  end
end
