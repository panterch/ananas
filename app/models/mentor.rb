class Mentor < ActiveRecord::Base
  has_many :team_mentors
  has_many :teams, through: :team_mentors

  def to_s
    job_title
  end
end
