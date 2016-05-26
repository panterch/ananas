require 'rails_helper'

RSpec.describe Rating do
  describe '.average_vote' do
    it 'returns the average of all votes rounded to the nearest 0.5' do
      rating1 = build :rating, votes: { team_vote: '5', business_idea_vote: '1', progress_vote: '2' }
      rating2 = build :rating, votes: { team_vote: '5', business_idea_vote: '1', progress_vote: '2' }

      expect(Rating.average_vote([rating1, rating2])).to eq 2.5
    end

    it 'returns nil when no votes are present' do
      expect(Rating.average_vote([])).to be_nil
    end
  end

  describe '#average_vote' do
    it 'returns the average of all votes rounded to the nearest 0.5' do
      rating = build :rating, votes: { team_vote: '5', business_idea_vote: '1', progress_vote: '2' }

      expect(rating.average_vote).to eq 2.5
    end
  end
end
