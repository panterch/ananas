class Event < ActiveRecord::Base

  belongs_to :mentor
  belongs_to :team

  validates_presence_of :summary, :start_at, :end_at

  def to_s
    self.summary
  end
end
