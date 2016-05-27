class MembersController < CrudController
  belongs_to :team, optional: true

  def member_params
    permitted_params = params.require(:member)

    permitted_params.permit([
      :name,
      :description,
      :avatar,
      HasVcardSupport.permitted_params
    ])
  end

  def create
    create! do |format|
      format.html

      format.js do
        resource.team_members.create(team_id: params[:team_id]) if params[:team_id].present?
      end
    end
  end
end
