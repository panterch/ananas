class TeamMembersController < CrudController
  belongs_to :team, optional: true
  belongs_to :member, optional: true

  def team_member_params
    permitted_params = params.require(:team_member)

    permitted_params.permit([
      :team_id,
      :member_id,
      :active
    ])
  end
end
