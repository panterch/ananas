class ExpertSession < Event
  belongs_to :mentor
  belongs_to :team

  after_create :create_attendances

  def prefill(mentor)
    self.summary = "Expert Session with #{mentor}"
  end

  def create_attendances
    attendances.create!(state: :attending, guest: mentor)
  end
end

