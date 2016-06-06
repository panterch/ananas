class Member < ActiveRecord::Base
  has_one :team_member, dependent: :destroy
  has_one :team, through: :team_member
  has_one :user, as: :profile

  include HasVcard

  mount_uploader :avatar, AvatarUploader

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
