class TeamsController < CrudController
  def team_params
    permitted_params = params.require(:team)

    permitted_params.permit([
      :name,
      :description
    ])
  end
end
