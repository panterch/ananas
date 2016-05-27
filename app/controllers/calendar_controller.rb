class CalendarController < ApplicationController
  skip_authorization_check
  skip_before_action :authenticate_user!

  def events
    calendar = Icalendar::Calendar.new
    calendar.publish

    events = Event.accessible_by(current_ability).includes(attendances: { guest: :user })
    events.map do |event|
      calendar.add_event CalendarConverter.event(event)
    end

    render text: calendar.to_ical, content_type: Mime::ICS
  end

  private

  def current_user
    User.find_by_calendar_token! params[:token]
  end
end
