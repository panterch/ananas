class TeamMentorsController < CrudController
  belongs_to :team, optional: true
  belongs_to :mentor, optional: true
  skip_before_action :verify_authenticity_token, only: :new_form

  def new_form
    @mentor = Mentor.new
  end

  def team_mentor_params
    permitted_params = params.require(:team_mentor)

    permitted_params.permit([
      :team_id,
      :mentor_id,
      :active
    ])
  end
end
