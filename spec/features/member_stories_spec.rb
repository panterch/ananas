feature "Signing in" do
  background do
    @user = create(:user, email: 'user@example.com', password: 'welcome', password_confirmation: 'welcome', admin: true)
    visit '/users/sign_in'

    fill_in 'Email', :with => 'user@example.com'
    fill_in 'Password', :with => 'welcome'
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully'
  end

  scenario "Displaying without any members" do
    visit '/members'
    expect(page).to have_content 'Founder'
  end

  scenario "Displaying a single member" do
    create(:member, description: "The members")
    visit '/members'
    expect(page).to have_content 'The members'
  end

  scenario "Paginating on description" do
    30.times do |i|
      create(:member, description: "The #{i.ordinalize} member")
    end
    visit '/members'
    expect(page).to have_content '1st member'
    expect(page).to have_content '20th member'

    click_link '2'
    expect(page).to have_content '25th member'
  end

  scenario "Search on members" do
    create(:member, description: "Hacker")
    create(:member, description: "Designer")
    visit '/members'
    fill_in '[by_text]', with: 'Designer'
    click_button 'search'
    expect(page).to have_content 'Designer'
    expect(page).to have_no_content 'Hacker'
  end

  scenario "Rendering the member edit form and displaying team info" do
    @member = create(:member, description: "Hacker")
    @team = create(:team, name: 'Team Rocket')
    @team.members << @member
    visit "/members/#{@member.id}"
    expect(page).to have_content("Team Rocket")
  end

  scenario "Rendering the member new form" do
    visit "/members/new"
    expect(page).to have_content("Founder")
  end

end
