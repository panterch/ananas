require 'rails_helper'

describe Event, type: :model do
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

  context 'today' do
    it 'builds an event for today' do
      @today = Event.today
      expect(@today.new_record?).to be_truthy
      expect(@today.start_at).to eq(Date.today.beginning_of_day)
    end
    it 'adds today to an event list' do
      create :event, start_at: Date.today - 2.days, end_at: Date.today - 2.days
      create :event, start_at: Date.today + 2.days, end_at: Date.today + 2.days

      events = Event.add_today(Event.all)
      expect(events.size).to eq(3)
      expect(events.second.summary).to eq('Today')
    end
  end

  context '.attended_by' do
    let(:user) { create :user }

    it 'does include events that the user did attend' do
      event = create :event
      create :attendance, event: event, guest: user, state: 'attending'

      expect(Event.attended_by(user)).to include event
    end

    it 'does not include events that the user did not attend' do
      event = create :event
      create :attendance, event: event, guest: user, state: 'declined'

      expect(Event.attended_by(user)).not_to include event
    end

    it 'does not include events to which the user was not invited' do
      event = create :event

      expect(Event.attended_by(user)).not_to include event
    end
  end

  context '.unrated' do
    it 'includes events that are not rated yet' do
      event = create :event

      expect(Event.unrated).to include(event)
    end


    it 'does not include events that the user has rated' do
      event = create :event
      create :rating, event: event

      expect(Event.unrated).not_to include event
    end
  end
end
