class Mentor < ActiveRecord::Base
  has_many :team_mentors
  has_many :teams, through: :team_mentors
  has_many :mentorings

  # VCards
  # ======
  has_one :vcard, as: :reference, class_name: 'HasVcards::Vcard', autosave: true
  accepts_nested_attributes_for :vcard

  include PgSearch
  pg_search_scope :by_text, using: { tsearch: { prefix: true } },
    against: [ :job_title, :who_i_am, :experience, :interests, :motivation ]

  def vcard_with_autobuild
    vcard_without_autobuild || build_vcard
  end
  alias_method_chain :vcard, :autobuild

  def to_s
    job_title
  end
end
