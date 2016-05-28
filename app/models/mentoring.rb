class Mentoring < Event

  belongs_to :mentor
  belongs_to :team

  after_create :create_attendances

  def prefill(team)
    self.mentor = team.mentor
    self.summary = "Mentoring #{team.mentor} and #{team}"
    self.start_at = Time.now.beginning_of_hour
    self.end_at = self.start_at + 2.hour
  end

  def create_attendances
    attendances.create!(state: :invited, guest: self.mentor)
    team.members.each do |member|
      attendances.create!(state: :invited, guest: member)
    end
  end

end
