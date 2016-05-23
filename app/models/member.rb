class Member < ActiveRecord::Base
  has_many :team_members
  has_many :teams, through: :team_members

  include PgSearch
  pg_search_scope :by_text, using: {tsearch: {prefix: true}},
    against: [:name, :description]

  def to_s
    name
  end
end
