class Team < ActiveRecord::Base
  has_many :team_members, dependent: :destroy
  has_many :members, through: :team_members
  has_many :mentorings, dependent: :restrict_with_error
  has_many :ratings, dependent: :destroy

  has_many :team_mentors, dependent: :destroy
  has_many :mentors, through: :team_mentors

  has_one  :user, as: :profile

  include HasVcard

  mount_uploader :avatar, AvatarUploader

  include PgSearch
  pg_search_scope :by_text,
    using: { tsearch: { prefix: true } },
    against: [ :name, :description ],
    associated_against: {
      vcard: HasVcardSupport.pg_search_against
    }

  def mentor
    mentors.first
  end

  def to_s
    name
  end
end
