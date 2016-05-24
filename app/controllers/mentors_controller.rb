class MentorsController < CrudController
  has_scope :by_text

  def mentor_params
    permitted_params = params.require(:mentor)

    permitted_params.permit([
      :job_title,
      :who_i_am,
      :experience,
      :interests,
      :motivation,
      HasVcardSupport.permitted_params
    ])
  end
end
