require 'rails_helper'

describe User, type: :model do

  describe '.find_by_calendar_token!' do
    let!(:user) { create :user, id: 23 }

    it 'raises an exception for unknown users' do
      expect do
        User.find_by_calendar_token! "#{user.calendar_token[0...40]}666"
      end.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'raises an exception for invalid tokens' do
      expect do
        User.find_by_calendar_token! '5d81f9b3e7742d10ae6907bd9c906f0d82ecf41123'
      end.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'returns the user for a valid token' do
      expect(User.find_by_calendar_token! user.calendar_token).to eq user
    end
  end

  describe '#calendar_token' do
    let(:user) { build :user, id: '23', encrypted_password: 'secret' }

    it 'generates a hash and appends the ID' do
      expect(user.calendar_token).to eq 'c0c7467cc203bd328ce23389a6921e3d233d8e1923'
    end

    it 'generates a different hash when the password changes' do
      token = user.calendar_token
      user.encrypted_password = 'changed'

      expect(user.calendar_token).not_to eq token
    end
  end
end
