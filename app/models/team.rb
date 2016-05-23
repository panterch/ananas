class Team < ActiveRecord::Base
  has_many :team_members
  has_many :members, through: :team_members

  def to_s
    name
  end
end
