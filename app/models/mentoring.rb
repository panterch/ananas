class Mentoring < Event

  belongs_to :mentor
  belongs_to :team

  def prefill(team)
    self.mentor = team.mentor
    self.summary = "Mentoring #{team.mentor} and #{team}"
    self.start_at = Time.now.beginning_of_hour
    self.end_at = self.start_at + 2.hour
  end

end
