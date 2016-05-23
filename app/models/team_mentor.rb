class TeamMentor < ActiveRecord::Base
  belongs_to :team
  belongs_to :mentor

  def to_s
    "%s mentoring %s" % [mentor, team]
  end
end
