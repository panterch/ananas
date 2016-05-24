class MentorsController < CrudController
  belongs_to :mentor, optional: true

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
end
