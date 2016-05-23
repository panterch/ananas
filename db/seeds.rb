Faker::Name.name
Faker::Internet.safe_email
Faker::Internet.url
Faker::Name.title
Faker::Company.name
Faker::Company.catch_phrase

unless User.exists?(email: 'panter@example.com')
  User.create!(email: 'panter@example.com', password: 'welcome', password_confirmation: 'welcome', admin: true)
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
