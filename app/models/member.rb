class Member < ActiveRecord::Base
  has_one :team_member, dependent: :destroy
  has_one :team, through: :team_member
  has_one :user, as: :profile
  scope :with_no_user, -> {
    includes(:user).where(users: { id: nil })
  }

  include HasVcard

  def name
    vcard.full_name
  end

  def name=(value)
    vcard.full_name = value
  end

  mount_uploader :avatar, AvatarUploader

  include PgSearch
  # To allow searching for vcard on team as no nested
  # associated_against queries are supported yet
  has_one :team_vcard, through: :team, source: :vcard
  pg_search_scope :by_text,
    using: { tsearch: { prefix: true } },
    against: [ :description ],
    associated_against: {
      vcard: HasVcardSupport.pg_search_against,
      team_vcard: HasVcardSupport.pg_search_against
    }

  def to_s
    name
  end
end
