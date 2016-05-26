Faker::Name.name
Faker::Internet.safe_email
Faker::Internet.url
Faker::Name.title
Faker::Company.name
Faker::Company.catch_phrase

(5 - Mentor.count).times do
  Mentor.create!(
    name: Faker::Name.name,
    job_title: Faker::Name.title,
    who_i_am: Faker::Company.bs,
    experience: (3.times.map { Faker::Hacker.ingverb }).join(', '),
    interests:  (3.times.map { Faker::Hacker.ingverb }).join(', '),
    motivation: Faker::Company.bs,
    remote_avatar_url: Faker::Avatar.image(Faker::Name.title, "50x50"),
    vcard: HasVcards::Vcard.new(
      full_name: Faker::Name.title + ' ' + Faker::Name.first_name + ' ' + Faker::Name.last_name,
      given_name: Faker::Name.first_name,
      family_name: Faker::Name.last_name,
      extended_address: Faker::Address.street_address(include_secondary = true),
      country_name: Faker::Address.country,
      postal_code: Faker::Address.zip_code
    )
  )
end

(6 - Member.count).times do
  Member.create!(
    name: Faker::Name.name,
    description: Faker::Name.title,
    remote_avatar_url: Faker::Avatar.image(Faker::Name.title, "50x50")
  )
end

(3 - Team.count).times do
  Team.create!(
    name: Faker::App.name,
    description: "We #{Faker::Company.bs} and #{Faker::Company.bs}.",
    remote_avatar_url: Faker::Avatar.image(Faker::Name.title, "50x50")
  )
end

Team.all.each_with_index do |team, i|
  unless team.team_members.exists?
    rand(1..2).times do
      TeamMember.create!(
        team: team,
        member: Member.includes(:team_members).where( team_members: { id: nil } ).first
      )
    end
  end

  unless team.team_mentors.exists?
    TeamMentor.create!(
      team: team,
      mentor: Mentor.includes(:team_mentors).where( team_mentors: { id: nil } ).first
    )
  end

end

program_start = DateTime.now.beginning_of_week
program_start = program_start.change(hour: 8)

unless Event.exists?
  Event.create!(summary: 'Kickoff Event',
                start_at: program_start,
                end_at: program_start + 2.hours)

  Event.create!(summary: 'First Milestone Event',
                start_at: program_start + 1.month,
                end_at: program_start + 1.month + 2.hours)

  Event.create!(summary: 'Second Milestone Event',
                start_at: program_start + 2.month,
                end_at: program_start + 2.month + 2.hours)

  Event.create!(summary: 'Grande Finale',
                start_at: program_start + 3.month,
                end_at: program_start + 3.month + 2.hours)
end

Team.all.each_with_index do |team, i|
  next if team.mentorings.exists?
  mentoring_at = program_start + rand(1..5).days
  mentoring_at = mentoring_at.change(hour: rand(8..18))
  (1..11).each do |i|
     Mentoring.create!(
      summary: "Mentoring #{i} Team #{team.name}",
      start_at: mentoring_at + i.weeks,
      end_at: mentoring_at + i.weeks + 1.hour,
      team: team,
      mentor: team.mentors.first
     )
  end
end

# create admin user
unless User.exists?(email: 'panter@example.com')
  User.create!(
    email: 'panter@example.com',
    password: 'welcome',
    password_confirmation: 'welcome',
    admin: true,
    profile: Mentor.first)
end

# create user for every second mentor and member
(Mentor.where('MOD(ID, 2) = 0') + Member.where('MOD(ID, 2) = 0')).each do |p|
  next if p.user
  User.create!(
    email: Faker::Internet.safe_email,
    password: 'welcome',
    password_confirmation: 'welcome',
    profile: p)
end
