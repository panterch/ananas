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
    end
  end
end
