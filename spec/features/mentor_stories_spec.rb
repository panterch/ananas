feature "Mentor management" do
  background do
    sign_in_admin
  end

  scenario "Displaying without any mentors" do
    visit mentors_path
    expect(page).to have_content 'Expert'
  end

  scenario "Displaying a single mentors" do
    create(:mentor, job_title: "The mentor's occupation")
    visit mentors_path
    expect(page).to have_content 'occupation'
  end

  scenario "Paginating on mentors" do
    30.times do |i|
      create(:mentor, job_title: "The #{i.ordinalize} mentor's occupation")
    end
    visit mentors_path
    expect(page).to have_content '1st mentor'
    expect(page).to have_content '20th mentor'

    click_link '2'
    expect(page).to have_content '25th mentor'
  end

  scenario "Search on mentors" do
    create(:mentor, job_title: "Hacker")
    create(:mentor, job_title: "Designer")
    visit mentors_path
    fill_in '[by_text]', with: 'Designer'
    click_button 'search'
    expect(page).to have_content 'Designer'
    expect(page).to have_no_content 'Hacker'
  end


  scenario "Rendering the mentor edit form and displaying team info" do
    @mentor = create(:mentor, job_title: "Hacker")
    @team = create(:team, name: 'Team Rocket')
    @team.mentors << @mentor
    visit mentor_path(@mentor)
    expect(page).to have_content("Team Rocket")
  end

  scenario "Rendering the mentor new form" do
    visit new_mentor_path
    expect(page).to have_content("Expert")
  end

end
