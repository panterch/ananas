class TeamMentorsController < CrudController
  belongs_to :team, optional: true
  belongs_to :mentor, optional: true

  def team_mentor_params
    permitted_params = params.require(:team_mentor)

    permitted_params.permit([
      :team_id,
      :mentor_id,
      :active
    ])
  end
end
