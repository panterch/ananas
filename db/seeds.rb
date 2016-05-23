Faker::Name.name
Faker::Internet.safe_email
Faker::Internet.url
Faker::Name.title
Faker::Company.name
Faker::Company.catch_phrase

unless User.exists?(email: 'panter@example.com')
  User.create!(email: 'panter@example.com', password: 'welcome', password_confirmation: 'welcome')
end

(10 - User.count).times do
  User.create!(email: Faker::Internet.safe_email, password: 'welcome', password_confirmation: 'welcome')
end

(100 - Mentor.count).times do
  Mentor.create!(
    name: Faker::Name.name,
    job_title: Faker::Name.title,
    who_i_am: Faker::Company.bs,
    experience: (3.times.map { Faker::Hacker.ingverb }).join(', '),
    interests:  (3.times.map { Faker::Hacker.ingverb }).join(', '),
    motivation: Faker::Company.bs)
end

(150 - Member.count).times do
  Member.create!(
    name: Faker::Name.name,
    description: Faker::Name.title)
end

(40 - Team.count).times do
  Team.create!(
    name: Faker::App.name,
    description: "We #{Faker::Company.bs} and #{Faker::Company.bs}.")
end

Team.all.each_with_index do |team, i|
  unless team.team_members.exists?
    rand(1..3).times do
      TeamMember.create!(
        team: team,
        member: Member.includes(:team_members).where( team_members: { id: nil } ).first)
    end
  end

  unless team.team_mentors.exists?
    TeamMentor.create!(
      team: team,
      mentor: Mentor.includes(:team_mentors).where( team_mentors: { id: nil } ).first)
  end

end



