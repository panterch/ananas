feature "Member management" do
  background do
    sign_in_admin
  end

  scenario "Displaying without any members" do
    visit members_path
    expect(page).to have_content 'Founder'
  end

  scenario "Displaying a single member" do
    create(:member, description: "The members")
    visit members_path
    expect(page).to have_content 'The members'
  end

  scenario "Paginating on description" do
    30.times do |i|
      create(:member, description: "The #{i.ordinalize} member")
    end
    visit members_path
    expect(page).to have_content '1st member'
    expect(page).to have_content '20th member'

    click_link '2'
    expect(page).to have_content '25th member'
  end

  scenario "Search on members" do
    create(:member, description: "Hacker")
    create(:member, description: "Designer")
    visit members_path
    fill_in '[by_text]', with: 'Designer'
    click_button 'search'
    expect(page).to have_content 'Designer'
    expect(page).to have_no_content 'Hacker'
  end

  scenario "Rendering the member edit form and displaying team info" do
    @member = create(:member, description: "Hacker")
    @team = create(:team, name: 'Team Rocket')
    @team.members << @member
    visit member_path(@member)
    expect(page).to have_content("Team Rocket")
  end

  scenario "Rendering the member new form" do
    visit new_member_path
    expect(page).to have_content("Founder")
  end

end
