class Mentor < ActiveRecord::Base
  has_many :team_mentors, dependent: :destroy
  has_many :teams, through: :team_mentors, dependent: :restrict_with_error
  has_many :mentorings, dependent: :restrict_with_error
  has_many :ratings, dependent: :destroy
  has_one  :user, as: :profile

  include HasVcard

  mount_uploader :avatar, AvatarUploader

  include PgSearch
  pg_search_scope :by_text,
    using: { tsearch: { prefix: true } },
    against: [ :job_title, :who_i_am, :experience, :interests, :motivation ],
    associated_against: {
      vcard: HasVcardSupport.pg_search_against
    }

  def to_s
    vcard.full_name.blank? ? 'Anonymous Mentor' : vcard.full_name
  end
end
