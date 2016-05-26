require 'rails_helper'

RSpec.describe Rating do
  describe '#average_vote' do
    it 'returns the average of all votes rounded to the nearest 0.5' do
      rating = build :rating, votes: { team_vote: '5', business_idea_vote: '1', progress_vote: '2' }

      expect(rating.average_vote).to eq 2.5
    end
  end
end
