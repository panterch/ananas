class Mentor < ActiveRecord::Base
  has_many :team_mentors, dependent: :destroy
  has_many :teams, through: :team_mentors, dependent: :restrict_with_error
  has_many :mentorings, dependent: :restrict_with_error
  has_many :expert_sessions, dependent: :restrict_with_error
  has_many :ratings, dependent: :destroy
  has_one  :user, as: :profile
  scope :with_no_user, -> {
    includes(:user).where(users: { id: nil })
  }

  include HasVcard

  mount_uploader :avatar, AvatarUploader

  include PgSearch
  pg_search_scope :by_text,
    using: { tsearch: { prefix: true } },
    against: [ :job_title, :who_i_am, :experience, :interests, :motivation ],
    associated_against: {
      vcard: HasVcardSupport.pg_search_against
    }

  # a mentor may be an lone expert or may have teams associated which makes him
  # to a real mentor
  def has_mentoring?
    0 < self.team_mentors_count
  end

  def to_s
    name
  end
end
