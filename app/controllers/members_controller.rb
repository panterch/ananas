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
end
