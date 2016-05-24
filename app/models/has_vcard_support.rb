class HasVcardSupport
  def self.permitted_params
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
  end

  def self.pg_search_against
    [ :full_name, :family_name, :given_name ]
  end
end
