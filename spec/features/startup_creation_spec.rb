feature 'Startup creation' do
  before { sign_in_admin }
  let(:startup_name) { 'Randensalat Inc.' }

  scenario 'implicit member creation', js: true do
    expect(Team.exists?(name: startup_name)).to be_falsy
    visit '/teams'

    click_link 'add'
    expect(page).not_to have_content 'You are not authorized to access this page'

    fill_in 'team[name]', with: startup_name
    fill_in 'team[description]', with: 'Mjamjam'
    fill_in 'team[vcard_attributes][full_name]', with: 'Bruce Wayne'
    fill_in 'team[vcard_attributes][address_attributes][street_address]', with: 'Aegeristr. 123'
    fill_in 'team[vcard_attributes][address_attributes][postal_code]', with: '6300'
    fill_in 'team[vcard_attributes][address_attributes][locality]', with: 'Zug'

    click_button 'Create Startup'

    expect(page).to have_content 'Startup was successfully created'
    expect(Team.exists?(name: startup_name)).to be_truthy

    # add new member (plus icon)
    find("a[href$='/team_members/new']").click

    click_link 'create new member'
    fill_in 'member[name]', with: 'Alexander Adam'
    fill_in 'member[vcard_attributes][family_name]', with: 'Adam'
    fill_in 'member[vcard_attributes][given_name]', with: 'Alexander'

    team = Team.where(name: startup_name).first
    expect(team.members).to be_empty
    expect(team.team_members).to be_empty

    find('a', text: 'SAVE').click
    expect(page).to have_content 'Alexander Adam'

    team = Team.where(name: startup_name).first
    expect(team.team_members).to be_one
    expect(team.members.uniq).to be_one
  end
end
