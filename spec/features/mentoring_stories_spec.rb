feature "Mentoring events" do
  background do
    @user = create(:user, email: 'user@example.com', password: 'welcome', password_confirmation: 'welcome', admin: true)
    visit '/users/sign_in'

    fill_in 'Email', :with => 'user@example.com'
    fill_in 'Password', :with => 'welcome'
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully'
  end

  scenario "displays mentorings on timeline" do
    create :mentoring, summary: 'First Mentoring'
    visit '/events/timeline'
    expect(page).to have_content 'First Mentoring'
  end

  scenario "edits mentorings from timeline" do
    create :mentoring, summary: 'First Mentoring'
    visit '/events/timeline'
    click_link 'Edit event'
    expect(page).to have_field 'Summary'
  end

end
