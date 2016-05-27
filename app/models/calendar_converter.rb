module CalendarConverter
  def self.event(event)
    Icalendar::Event.new.tap do |ical|
      ical.summary = event.summary
      ical.description = event.description
      ical.dtstart = event.start_at
      ical.dtend = event.end_at
      ical.url = event.url
      ical.created = event.created_at
      ical.last_modified = event.updated_at

      event.attendances.each do |attendance|
        ical.append_attendee self.attendee(attendance)
      end
    end
  end

  def self.attendee(attendance)
    guest = attendance.guest
    user = guest.user

    uri =
      if user and user.email.present?
        "mailto:#{user.email}"
      else
        # TODO: use profile URL or something
        "http://ananas.local"
      end

    role =
      if guest.is_a? Mentor
        'CHAIR'
      else
        'REQ-PARTICIPANT'
      end

    Icalendar::Values::CalAddress.new(uri, {
      cn: guest.name,
      cutype: 'INDIVIDUAL',
      role: role,
      partstat: {
        'invited'   => 'TENTATIVE',
        'attending' => 'ACCEPTED',
        'declined'  => 'DECLINED',
      }[attendance.state]
    })
  end
end
