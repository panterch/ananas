require_relative '../features'

module Features
  module SessionHelpers
    def sign_up_with(email, password)
      visit user_session_path

      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_button 'Log in'

      expect(page).to have_content 'Signed in successfully'
    end

    def sign_in_admin
      user = create :user, profile_type: 'Mentor', admin: true
      create :mentor, user: user
      expect(user).to be_mentor
      sign_up_with user.email, user.password
    end

    def sign_in_mentor
      user = create :user
      sign_up_with user.email, user.password
    end
  end
end
