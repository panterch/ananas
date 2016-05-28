require 'rails_helper'

describe Mentoring, type: :model do

  context '#prefill' do
    let(:mentor) { create(:mentor ) }
    let(:team) { create(:team, mentors: [mentor], name: 'T') }

    it 'prefills the mentoring' do
      @mentoring = team.mentorings.build()
      @mentoring.prefill(team)
      expect(@mentoring.mentor).to eq(mentor)
      expect(@mentoring.summary).to eq("Mentoring Anonymous Mentor and T")
    end

  end
end
