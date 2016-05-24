class TeamsController < CrudController
  belongs_to :mentor, optional: true

  def team_params
    permitted_params = params.require(:team)

    permitted_params.permit([
      :name,
      :description,
      :avatar,
      HasVcardSupport.permitted_params
    ])
  end
end
