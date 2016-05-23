class TeamMentorsController < CrudController
  def team_mentor_params
    permitted_params = params.require(:team_mentor)

    permitted_params.permit([
      :team_id,
      :mentor_id,
      :active
    ])
  end
end
