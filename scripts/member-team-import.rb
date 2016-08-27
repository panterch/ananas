require 'csv'

headers = [
  :vertical,
  :team_name,
  :given_name,
  :family_name,
  :email,
  :date_of_birth,
  :nationality,
  :accommodation,
  :arriving,
  :leaving,
  :dietary,
  :attending_days,
  :stipends?,
  :comment
]

Member.destroy_all
Team.destroy_all

CSV.foreach('members.csv', headers: headers) do |row|
  next if row[:team_name] == 'Startup'

  email = HasVcards::PhoneNumber.new(
    phone_number_type: 'email',
    number: row[:email].strip
  ) unless row[:email].blank?

  contacts = [email].compact

  team = Team.includes(:vcard).where(has_vcards_vcards: { full_name: row[:team_name] }).first
  unless team
    team = Team.create!(
      vcard: HasVcards::Vcard.new(full_name: row[:team_name])
    )
  end

  member = Member.new(
    team: team,
    vcard: HasVcards::Vcard.new(
      given_name: row[:given_name],
      family_name: row[:family_name],
      contacts: contacts
    )
  )

  member.save
end
