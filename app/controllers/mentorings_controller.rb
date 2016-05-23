class MentoringsController < CrudController
  def mentoring_params
    permitted_params = params.require(:mentoring)

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
