require 'rails_helper'

RSpec.describe RatingsHelper do
  describe '#vote_as_stars' do
    it 'returns half stars for 0.5 votes' do
      expect(helper.vote_as_stars(2.5)).to eq(
        '<i class="material-icons">star</i>' \
        '<i class="material-icons">star</i>' \
        '<i class="material-icons">star_half</i>' \
        '<i class="material-icons">star_border</i>' \
        '<i class="material-icons">star_border</i>'
      )
    end

    it 'returns full star for non-half votes' do
      expect(helper.vote_as_stars(1)).to eq(
        '<i class="material-icons">star</i>' \
        '<i class="material-icons">star_border</i>' \
        '<i class="material-icons">star_border</i>' \
        '<i class="material-icons">star_border</i>' \
        '<i class="material-icons">star_border</i>'
      )
    end

    it 'returns nil if the vote is nil' do
      expect(helper.vote_as_stars(nil)).to be_nil
    end
  end
end
