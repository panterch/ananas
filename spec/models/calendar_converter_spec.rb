require 'rails_helper'

describe CalendarConverter, type: :model do
  let(:mentor) { build :mentor, name: 'Mentor', user: build(:user, email: 'mentor@example.com') }
  let(:member) { build :member, name: 'Member', user: build(:user, email: 'member@example.com') }

  let(:event) {
    Event.new({
      summary: 'summary',
      description: 'description',
      start_at: DateTime.parse('2001-02-03 06:00:00'),
      end_at: DateTime.parse('2001-02-03 18:00:00'),
      url: 'url',
      created_at: DateTime.parse('2001-01-01 12:00:00'),
      updated_at: DateTime.parse('2001-01-01 13:00:00'),
      attendances: [
        build(:attendance, guest: mentor),
        build(:attendance, guest: member),
      ]
    })
  }

  describe '.event' do
    let(:ical_event) { CalendarConverter.event(event) }

    it 'returns an icalendar event' do
      expect(ical_event.summary).to eq 'summary'
      expect(ical_event.description).to eq 'description'
      expect(ical_event.dtstart.to_s).to eq '2001-02-03T07:00:00+01:00'
      expect(ical_event.dtend.to_s).to eq '2001-02-03T19:00:00+01:00'
      expect(ical_event.url.to_s).to eq 'url'
      expect(ical_event.created.to_s).to eq '2001-01-01T13:00:00+01:00'
      expect(ical_event.last_modified.to_s).to eq '2001-01-01T14:00:00+01:00'
    end

    it 'appends attendances of the event' do
      expect(ical_event.attendee).to eq [
        URI.parse('mailto:mentor@example.com'),
        URI.parse('mailto:member@example.com'),
      ]
    end
  end

  describe '.attendee' do
    it 'returns an icalendar address for a mentor' do
      ical_attendee = CalendarConverter.attendee(event.attendances.first)

      expect(ical_attendee).to eq URI.parse('mailto:mentor@example.com')
      expect(ical_attendee.ical_params['cn']).to eq 'Mentor'
      expect(ical_attendee.ical_params['cutype']).to eq 'INDIVIDUAL'
      expect(ical_attendee.ical_params['role']).to eq 'CHAIR'
      expect(ical_attendee.ical_params['partstat']).to eq 'TENTATIVE'
    end

    it 'returns an icalendar address for a member' do
      ical_attendee = CalendarConverter.attendee(event.attendances.second)

      expect(ical_attendee).to eq URI.parse('mailto:member@example.com')
      expect(ical_attendee.ical_params['cn']).to eq 'Member'
      expect(ical_attendee.ical_params['cutype']).to eq 'INDIVIDUAL'
      expect(ical_attendee.ical_params['role']).to eq 'REQ-PARTICIPANT'
      expect(ical_attendee.ical_params['partstat']).to eq 'TENTATIVE'
    end

    it 'maps all attendance states' do
      attendance = event.attendances.first

      attendance.state = :invited
      expect(CalendarConverter.attendee(attendance).ical_params['partstat']).to eq 'TENTATIVE'

      attendance.state = :attending
      expect(CalendarConverter.attendee(attendance).ical_params['partstat']).to eq 'ACCEPTED'

      attendance.state = :declined
      expect(CalendarConverter.attendee(attendance).ical_params['partstat']).to eq 'DECLINED'
    end

    it 'falls back to some URL for attendances without a known email address' do
      attendance = event.attendances.first
      attendance.guest.user = nil

      expect(CalendarConverter.attendee(attendance)).to eq URI.parse('http://ananas.local')
    end
  end
end
