class Team < ActiveRecord::Base
  has_many :team_members
  has_many :members, through: :team_members

  has_many :team_mentors
  has_many :mentors, through: :team_mentors

  def to_s
    name
  end
end
