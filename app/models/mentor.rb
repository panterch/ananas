class Mentor < ActiveRecord::Base
  has_many :team_mentors
  has_many :teams, through: :team_mentors
  has_many :mentorings

  include PgSearch
  pg_search_scope :by_text, using: {tsearch: {prefix: true}},
    against: [:job_title, :who_i_am, :experience, :interests, :motivation]

  def to_s
    job_title
  end
end
