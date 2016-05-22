feature "Signing in" do
  background do
    @user = create(:user, email: 'user@example.com', password: 'welcome', password_confirmation: 'welcome')
  end

  scenario "Signing in with correct credentials" do
    visit '/users/sign_in'

    fill_in 'Email', :with => 'user@example.com'
    fill_in 'Password', :with => 'welcome'
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully'
  end

end
