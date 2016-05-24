class Member < ActiveRecord::Base
  has_many :team_members
  has_many :teams, through: :team_members

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
