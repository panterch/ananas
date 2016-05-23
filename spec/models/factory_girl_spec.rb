require 'spec_helper'

describe 'FactoryGirl' do
  describe 'a user by factory' do
    let(:user) { build(:user) }
    it('should be valid') { expect(user).to be_valid }
    it('should be a mentor') { expect(user.class).to eq(User) }
  end
end
