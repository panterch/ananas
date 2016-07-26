require 'rails_helper'

describe Member, type: :model do
  context '#name' do
    let(:member) { build(:member) }

    it 'uses the full_name if present' do
      member.vcard.full_name = 'Full'
      expect(member.name).to eq 'Full'
    end

    it 'uses given and family name if full_name is blank' do
      member.vcard.given_name = 'Given'
      member.vcard.family_name = 'Family'

      member.vcard.full_name = ''
      expect(member.name).to eq 'Family Given'

      member.vcard.full_name = nil
      expect(member.name).to eq 'Family Given'
    end

    it 'does not add bogus space if only one name is present' do
      member.vcard.full_name = nil
      member.vcard.family_name = nil
      member.vcard.given_name = 'Given'
      expect(member.name).to eq 'Given'

      member.vcard.family_name = 'Family'
      member.vcard.given_name = ''
      expect(member.name).to eq 'Family'
    end
  end

  context '#name=' do
    let(:member) { build(:member) }

    it 'sets the name' do
      member.name = 'Full Name'
      expect(member.name).to eq 'Full Name'
    end

    it 'sets the vcard full_name' do
      member.name = 'Full Name'
      expect(member.vcard.full_name).to eq 'Full Name'
    end
  end

  context '#to_s' do
    let(:member) { build(:member) }

    it 'returns a string' do
      expect(member.to_s).to be_a String
    end
  end
end
