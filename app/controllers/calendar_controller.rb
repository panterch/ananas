class CalendarController < ApplicationController
  skip_authorization_check
  skip_before_action :authenticate_user!
  before_action { User.find_by_calendar_token! params[:token] }

  def events
    calendar = Icalendar::Calendar.new
    calendar.publish

    Event.all.map do |event|
      calendar.add_event event.to_ical
    end

    render text: calendar.to_ical, content_type: Mime::ICS
  end
end
