class TeamMember < ActiveRecord::Base
  belongs_to :team
  belongs_to :member

  validates_presence_of :team, :member

  def to_s
    "%s of %s" % [member, team]
  end
end
