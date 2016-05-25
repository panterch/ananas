feature "Signing in" do
  background do
    @user = create(:user, email: 'user@example.com', password: 'welcome', password_confirmation: 'welcome')
    visit '/users/sign_in'

    fill_in 'Email', :with => 'user@example.com'
    fill_in 'Password', :with => 'welcome'
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully'
  end

  scenario "Displaying without any mentors" do
    visit '/mentors'
    expect(page).to have_content 'Mentor'
  end

  scenario "Displaying a single mentors" do
    create(:mentor, job_title: "The mentor's occupation")
    visit '/mentors'
    expect(page).to have_content 'occupation'
  end

  scenario "Paginating on mentors" do
    30.times do |i|
      create(:mentor, job_title: "The #{i.ordinalize} mentor's occupation")
    end
    visit '/mentors'
    expect(page).to have_content '1st mentor'
    expect(page).to have_content '20th mentor'

    click_link '2'
    expect(page).to have_content '25th mentor'
  end

  scenario "Search on mentors" do
    create(:mentor, job_title: "Hacker")
    create(:mentor, job_title: "Designer")
    visit '/mentors'
    fill_in '[by_text]', with: 'Designer'
    click_button 'search'
    expect(page).to have_content 'Designer'
    expect(page).to have_no_content 'Hacker'
  end

end
