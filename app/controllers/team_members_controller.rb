class TeamMembersController < CrudController
  def team_member_params
    permitted_params = params.require(:team_member)

    permitted_params.permit([
      :team_id,
      :member_id
    ])
  end
end
