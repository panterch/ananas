class Event < ActiveRecord::Base
  belongs_to :mentor
  belongs_to :team
  has_many :ratings, dependent: :destroy

  has_many :attendances

  validates_presence_of :summary, :start_at, :end_at

  default_scope -> () { order(:start_at) }

  def to_s
    summary
  end

  def overdue?
    end_at.past?
  end
end
