require 'rails_helper'

describe Mentoring, type: :model do

  let(:mentor) { create(:mentor ) }
  let(:team) { create(:team, mentors: [mentor], name: 'T') }

  context '#prefill' do

    it '#prefill' do
      @mentoring = team.mentorings.build()
      @mentoring.prefill(team)
      expect(@mentoring.mentor).to eq(mentor)
      expect(@mentoring.summary).to eq("Mentoring Anonymous Mentor and T")
    end
  end

  it '#create_attenances' do
    @member = create(:member, team: team)
    @mentoring = create(:mentoring, team: team, mentor: mentor)
    expect(@mentoring.attendances.count).to eq(2)
    expect(@mentoring.attendances.map(&:guest)).to include(mentor)
    expect(@mentoring.attendances.map(&:guest)).to include(@member)
  end
end
