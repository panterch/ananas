feature 'Startup creation' do
  background do
    sign_in_admin
  end

  let(:startup_name) { 'Randensalat Inc.' }

  scenario 'implicit member creation', js: true do
    visit teams_path
    expect(page).not_to have_content startup_name

    click_link 'add'
    expect(page).not_to have_content 'You are not authorized to access this page'

    fill_in 'team[name]', with: startup_name
    fill_in 'team[description]', with: 'Mjamjam'
    fill_in 'team[vcard_attributes][address_attributes][street_address]', with: 'Aegeristr. 123'
    fill_in 'team[vcard_attributes][address_attributes][postal_code]', with: '6300'
    fill_in 'team[vcard_attributes][address_attributes][locality]', with: 'Zug'

    click_button 'Save'

    expect(page).to have_content 'Startup was successfully created'

    # add new member (plus icon)
    find("a[href$='/team_members/new']").click

    click_link 'create new member'
    fill_in 'member[name]', with: 'Alexander Adam'
    fill_in 'member[vcard_attributes][family_name]', with: 'Adam'
    fill_in 'member[vcard_attributes][given_name]', with: 'Alexander'

    find('a', text: 'SAVE').click
    expect(page).to have_content 'Alexander Adam'
  end
end
