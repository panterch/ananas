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
      {
        vcard_attributes: [
          :id, :full_name, :nickname,
          :family_name, :given_name, :additional_name,
          {
            address_attributes: [
              :id, :street_address, :extended_address,
              :post_office_box, :postal_code,
              :locality, :country_name,
            ],
            contacts_attributes: [
              :id, :phone_number_type, :number, :_destroy,
            ],
          }
        ]
      }
    ])
  end
end
