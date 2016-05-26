class Event < ActiveRecord::Base
  belongs_to :mentor
  belongs_to :team
  has_many :ratings, dependent: :destroy

  has_many :attendances, dependent: :destroy

  validates_presence_of :summary, :start_at, :end_at

  default_scope -> { order(:start_at) }

  def to_s
    summary
  end

  def overdue?
    end_at.past?
  end

  # special event representing the current date
  def self.today
    Event.new(summary: 'Today',
              start_at: Date.today,
              end_at: Date.today)
  end

  # adds a today event to an array of events at the right position
  def self.add_today(events)
    events = events.to_a # decouple collection from AR to avoid updates
    events << Event.today
    return events.sort_by{ |e| e.start_at }
  end
end
