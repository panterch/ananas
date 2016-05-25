class MentorsController < CrudController

  # apply default scope
  has_scope :vcard_default_scope, default: nil, allow_blank: true, unless: :by_text?

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
