require 'rails_helper'

describe Mentor, type: :model do

  let(:mentor) { create(:mentor, name: 'Anonymous Mentor') }
  let(:team) { create(:team, mentors: [mentor], name: 'T') }

  it '#has_mentoring?' do
    expect(mentor.has_mentoring?).to be_falsey
    mentor.teams << team
    expect(mentor.has_mentoring?).to be_truthy
  end

end
