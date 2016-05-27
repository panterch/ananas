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
        # FIXME add security
        TeamMember.create!(team_id: params[:team_id], member_id: resource.id) if params[:team_id].present?
      end
    end
  end
end
