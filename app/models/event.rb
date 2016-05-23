class Event < ActiveRecord::Base

  validates_presence_of :summary, :start_at, :end_at

  def to_s
    self.summary
  end
end
