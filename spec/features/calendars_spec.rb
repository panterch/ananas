require 'rails_helper'

feature "Calendars", type: :feature do
  background do
    @user = create(:user, email: 'user@example.com', password: 'welcome', password_confirmation: 'welcome')
    @visible_event = create(:event, summary: 'visible event')
    @invisible_event = create(:event, summary: 'invisible event', mentor_id: 23)
  end

  scenario "Accessing a valid calendar URL renders an iCalendar file with the user's visible events" do
    visit calendar_events_path(@user.calendar_token)

    expect(page.body).to start_with "BEGIN:VCALENDAR\r\nVERSION:2.0"
    expect(page.body).to include 'SUMMARY:visible event'
    expect(page.body).not_to include 'SUMMARY:invisible event'
    expect(page.response_headers['Content-Type']).to eq 'text/calendar; charset=utf-8'
  end

  # TODO: Capybara.raise_server_errors is supposed to give us an error response
  # instead of the exception, investigate why this doesn't work
  scenario "Accessing an invalid calendar URL renders a 404" do
    expect do
      visit calendar_events_path('invalid')
    end.to raise_error(ActiveRecord::RecordNotFound)
  end
end
