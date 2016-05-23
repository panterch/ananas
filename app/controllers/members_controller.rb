class MembersController < CrudController
  def member_params
    permitted_params = params.require(:member)

    permitted_params.permit([
      :name,
      :description
    ])
  end
end
