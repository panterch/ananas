class Member < ActiveRecord::Base
  has_many :team_members
  has_many :teams, through: :team_members

  def to_s
    name
  end
end
