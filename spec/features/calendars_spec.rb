require 'rails_helper'

feature "Calendars", type: :feature do
  background do
    @user = create(:user, email: 'user@example.com', password: 'welcome', password_confirmation: 'welcome')
    @event = create(:event, summary: 'example event')
  end

  scenario "Accessing a valid calendar URL renders an ICS file" do
    visit "/calendar/#{@user.calendar_token}/events"

    expect(page.body).to start_with "BEGIN:VCALENDAR\r\nVERSION:2.0"
    expect(page.body).to include 'SUMMARY:example event'
    expect(page.response_headers['Content-Type']).to eq 'text/calendar; charset=utf-8'
  end

  # TODO: Capybara.raise_server_errors is supposed to give us an error response
  # instead of the exception, investigate why this doesn't work
  scenario "Accessing an invalid calendar URL renders a 404" do
    expect do
      visit '/calendar/invalid/events'
    end.to raise_error(ActiveRecord::RecordNotFound)
  end
end
