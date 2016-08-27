require 'csv'

headers = [
  :id,
  :user_code,
  :score,
  :mentor?,
  :expert?,
  :executive?,
  :investor?,
  :state,
  :sched_imported,
  :vertical,
  :industry,
  :given_name,
  :family_name,
  :organisation,
  :email,
  :comment,
  :website_state,
  :job_title,
  :who_i_am,
  :experience,
  :interests,
  :motivation,
  :phone_number,
  :linkedin_url,
  :image_url,
  :mentoring
]

Mentor.all.to_a.select{ |mentor| mentor.user.nil? }.each(&:destroy)

CSV.foreach('contacts.csv', headers: headers) do |row|
  next unless row[:expert?]

  email = HasVcards::PhoneNumber.new(
    phone_number_type: 'email',
    number: row[:email].strip
  ) unless row[:email].blank?

  phone = HasVcards::PhoneNumber.new(
    phone_number_type: 'phone',
    number: row[:phone_number]
  ) unless row[:phone_number].blank?

  linkedin = HasVcards::PhoneNumber.new(
    phone_number_type: 'linkedin',
    number: row[:linkedin_url]
  ) unless row[:linkedin_url].blank?

  contacts = [email, phone, linkedin].compact

  mentor = Mentor.new(
    job_title: row[:job_title],
    who_i_am: row[:who_i_am],
    experience: row[:experience],
    interests: row[:interests],
    motivation: row[:motivation],
    vcard: HasVcards::Vcard.new(
      given_name: row[:given_name],
      family_name: row[:family_name],
      contacts: contacts
    )
  )

  mentor.save
end
