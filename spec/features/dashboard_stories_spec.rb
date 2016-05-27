require 'rails_helper'

feature "Dashboard" do
  let(:mentor) { create :user }
  before { test_login mentor }

  scenario "create rating", :js do
    team = create :team
    event = create :event, summary: 'Spec Event', team: team
    create :attendance, event: event, guest: mentor, state: 'attending'

    visit mentor_dashboard_index_path(mentor)

    expect(page).to have_selector('.collection-item')
    find('.collection-item').click

    click_on 'Create Rating'

    wait_for_ajax

    expect(page).to have_content 'can\'t be blank', count: 3

    find('.rating_team_vote > i[data-value="2"]').click
    find('.rating_business_idea_vote > i[data-value="4"]').click
    find('.rating_progress_vote > i[data-value="5"]').click

    fill_in 'Comment', with: 'My comment'

    click_on 'Create Rating'

    wait_for_ajax

    rating = Rating.last
    expect(rating.comment).to eq 'My comment'
    expect(rating.team_vote).to eq "2"
    expect(rating.business_idea_vote).to eq "4"
    expect(rating.progress_vote).to eq "5"
  end
end
