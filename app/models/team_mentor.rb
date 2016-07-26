class TeamMentor < ActiveRecord::Base
  belongs_to :team
  belongs_to :mentor, counter_cache: true

  validates_presence_of :team, :mentor

  def to_s
    "%s mentoring %s" % [mentor, team]
  end
end
