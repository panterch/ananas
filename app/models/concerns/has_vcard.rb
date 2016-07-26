module HasVcard
  extend ActiveSupport::Concern

  module AutobuildVcard
    def vcard
      super || build_vcard
    end
  end

  included do
    has_one :vcard, as: :reference, class_name: 'HasVcards::Vcard', autosave: true, dependent: :destroy
    accepts_nested_attributes_for :vcard

    prepend AutobuildVcard
    scope :vcard_default_scope, ->(*) { includes(:vcard).order('has_vcards_vcards.family_name') }
  end

  def name
    vcard.full_name
  end

  def name=(value)
    vcard.full_name = value
  end
end
