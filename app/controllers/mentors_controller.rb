class MentorsController < CrudController
  def mentor_params
    mentor_params = params.require(:mentor)

    mentor_params.permit([
      :job_title,
      :who_i_am,
      :experience,
      :interests,
      :motivation
    ])
  end
end
