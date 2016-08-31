class ExpertSession < Event
  belongs_to :mentor
  belongs_to :team

  has_many :attendances, dependent: :destroy, autosave: true, class_name: 'ExpertSessionAttendance', foreign_key: :event_id, inverse_of: :event

  scope :bookable, -> { where('start_at > ?', Time.zone.now).where('team_id IS NULL') }
  scope :confirmed, -> { where.not(team_id: nil) }

  def self.unconfirmed
    includes(:attendances).select{|es| es.attendances.invited.present? }
  end

  def self.fresh
    where(team_id: nil).includes(:attendances).select{|es| es.attendances.invited.blank? }
  end

  before_validation :fill_up

  def fill_up
    self.end_at = start_at.in(1.hour)
    self.summary = "Expert Session with #{mentor}"
    attendances.build(state: :attending, guest: mentor) if attendances.empty?
  end

  def my_attendance
    attendances.where(guest: mentor).first
  end

  def accept_attendance(attendance)
    other_attendances = attendances - [my_attendance] - [attendance]
    other_attendances.each do |other_attendance|
      other_attendance.state = 'declined'
      other_attendance.save
    end

    attendance.state = 'attending'
    attendance.save

    self.team = attendance.guest.team
    save

    attendances.reload
  end

  def reject_attendance(attendance)
    attendance.state = 'declined'
    attendance.save

    self.team = nil if team == attendance.guest.team
    save
  end
end
