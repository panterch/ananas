feature "Mentoring events" do
  background do
    sign_in_admin
  end

  let(:mentor) { create(:mentor) }
  let(:team) { create(:team, mentors: [ mentor ]) }

  scenario "displays mentorings on timeline" do
    create :mentoring, summary: 'First Mentoring'
    visit timeline_events_path
    expect(page).to have_content 'First Mentoring'
  end

  scenario "edits mentorings from timeline" do
    create :mentoring, summary: 'First Mentoring'
    visit timeline_events_path
    click_link 'Edit event'
    expect(page).to have_field 'Summary'
  end

  pending "creates mentoring from team view", js: true do
    visit team_path(team)

    # add new mentoring (plus icon)
    find("a[href$='/teams/#{team.id}/mentorings/new']").click
    fill_in 'mentoring_summary', with: 'A new mentoring'

    find('a', text: 'SAVE').click
    expect(page).to have_content 'A new mentoring'
  end

  pending "reports validation errors on mentoring from team view", js: true do
    visit team_path(team)

    # add new mentoring (plus icon)
    find("a[href$='/teams/#{team.id}/mentorings/new']").click
    fill_in 'mentoring_summary', with: ''

    find('a', text: 'SAVE').click
    expect(page).to have_content "can't be blank"
  end

end
