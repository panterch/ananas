require 'spec_helper'

describe 'FactoryGirl' do
  describe 'a user by factory' do
    let(:user) { build(:user) }
    it('should be valid') { expect(user).to be_valid }
    it('should be a mentor') { expect(user.class).to eq(User) }
  end

  describe 'a mentor by factory' do
    let(:mentor) { build(:mentor) }
    it('should be valid') { expect(mentor).to be_valid }
    it('should be a mentoring') { expect(mentor.class).to eq(Mentor) }
  end

  describe 'a team by factory' do
    let(:team) { build(:team) }
    it('should be valid') { expect(team).to be_valid }
    it('should be a mentoring') { expect(team.class).to eq(Team) }

  end

  describe 'a mentoring by factory' do
    let(:mentoring) { build(:mentoring) }
    it('should be valid') { expect(mentoring).to be_valid }
    it('should be a mentoring') { expect(mentoring.class).to eq(Mentoring) }
    it('associates a mentor') { expect(mentoring.mentor).to be_valid}
    it('associates a team') { expect(mentoring.mentor).to be_valid}
  end

end
