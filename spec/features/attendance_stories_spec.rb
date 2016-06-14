feature "Attendance of Events" do
  background do
    sign_in_admin
  end

  scenario "Inviting Mentors to events", js: true do
    create :mentor, vcard_attributes: { full_name: "Mentor One" }
    event = create :event

    visit event_path(event)

    click_link 'add'

    expect(page).to have_css('.select-wrapper li.optgroup', text: 'Mentors', visible: false)
    find('.select-wrapper input').click #open the dropdown
    find('.select-wrapper li', text: 'Mentor One').click #select the option wanted

    click_link 'Save'

    within '.attendances' do
      expect(page).to have_content('Mentor One')
    end
  end

  scenario "Inviting Members to events", js: true do
    create :member, vcard_attributes: { full_name: "Member One" }
    event = create :event

    visit event_path(event)

    click_link 'add'

    expect(page).to have_css('.select-wrapper li.optgroup', text: 'Founders', visible: false)
    find('.select-wrapper input').click #open the dropdown
    find('.select-wrapper li', text: 'Member One').click #select the option wanted

    click_link 'Save'

    within '.attendances' do
      expect(page).to have_content('Member One')
    end
  end

end
