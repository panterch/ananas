require 'rails_helper'

RSpec.describe Event, type: :model do
  context 'overdue?' do
    it 'is true if date is past' do
      Timecop.freeze do
        from = DateTime.now.ago(2.hour)
        to = DateTime.now.ago(1.hour)

        event = create :event, start_at: from, end_at: to

        expect(event.overdue?).to be_truthy
      end
    end

    it 'is false if running now' do
      Timecop.freeze do
        from = DateTime.now.ago(2.hour)
        to = DateTime.now.in(2.hour)

        event = create :event, start_at: from, end_at: to

        expect(event.overdue?).to be_falsy
      end
    end
  end

  context 'attendances' do
    it 'starts with no attendances' do
      event = create :event
      expect(event.attendances).to be_empty
    end
  end
end
