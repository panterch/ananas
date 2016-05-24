class Team < ActiveRecord::Base
  has_many :team_members
  has_many :members, through: :team_members
  has_many :mentorings

  has_many :team_mentors
  has_many :mentors, through: :team_mentors

  include HasVcard

  include PgSearch
  pg_search_scope :by_text,
    using: { tsearch: { prefix: true } },
    against: [ :name, :description ],
    associated_against: {
      vcard: HasVcardSupport.pg_search_against
    }

  def to_s
    name
  end
end
