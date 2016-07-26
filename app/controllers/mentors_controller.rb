class MentorsController < CrudController

  # apply default scope
  has_scope :vcard_default_scope, default: nil, allow_blank: true, unless: :by_text?, only: :index

  def mentor_params
    permitted_params = params.require(:mentor)

    permitted_params.permit([
      :job_title,
      :who_i_am,
      :experience,
      :interests,
      :motivation,
      :avatar,
      HasVcardSupport.permitted_params
    ])
  end

  def create
    create! do |format|
      format.html

      format.js do
        resource.team_mentors.create(team_id: params[:team_id]) if params[:team_id].present?
      end
    end
  end
end
