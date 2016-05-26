class TeamMembersController < CrudController
  polymorphic_belongs_to :member, :team, optional: true
  skip_before_action :verify_authenticity_token, only: :new_form

  def new_form
    @member = Member.new
  end

  def team_member_params
    permitted_params = params.require(:team_member)

    permitted_params.permit([
      :team_id,
      :member_id,
      :active
    ])
  end
end
