require 'rails_helper'

describe CalendarConverter, type: :model do
  describe '.event' do
    let(:event) {
      Event.new({
        summary: 'summary',
        description: 'description',
        start_at: DateTime.parse('2001-02-03 06:00:00'),
        end_at: DateTime.parse('2001-02-03 18:00:00'),
        url: 'url',
        created_at: DateTime.parse('2001-01-01 12:00:00'),
        updated_at: DateTime.parse('2001-01-01 13:00:00'),
      })
    }

    it 'returns an icalendar event' do
      ical_event = CalendarConverter.event(event)

      expect(ical_event.summary).to eq 'summary'
      expect(ical_event.description).to eq 'description'
      expect(ical_event.dtstart.to_s).to eq '2001-02-03T06:00:00+00:00'
      expect(ical_event.dtend.to_s).to eq '2001-02-03T18:00:00+00:00'
      expect(ical_event.url.to_s).to eq 'url'
      expect(ical_event.created.to_s).to eq '2001-01-01T12:00:00+00:00'
      expect(ical_event.last_modified.to_s).to eq '2001-01-01T13:00:00+00:00'
    end
  end
end
