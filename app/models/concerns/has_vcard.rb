module HasVcard
  extend ActiveSupport::Concern

  included do
    has_one :vcard, as: :reference, class_name: 'HasVcards::Vcard', autosave: true
    accepts_nested_attributes_for :vcard

    alias_method_chain :vcard, :autobuild
  end

  def vcard_with_autobuild
    vcard_without_autobuild || build_vcard
  end
end
