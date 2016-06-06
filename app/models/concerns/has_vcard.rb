module HasVcard
  extend ActiveSupport::Concern

  included do
    has_one :vcard, as: :reference, class_name: 'HasVcards::Vcard', autosave: true, dependent: :destroy
    accepts_nested_attributes_for :vcard

    alias_method_chain :vcard, :autobuild
    scope :vcard_default_scope, ->(*) { includes(:vcard).order('has_vcards_vcards.family_name') }
  end

  def vcard_with_autobuild
    vcard_without_autobuild || build_vcard
  end

end
