module AuthHelper
  def login_as(member)
    visit "/sign-in"
    within '#sign_in' do
      fill_in("member[email]", :with => member.email)
      fill_in("member[password]", :with => 'password')
      click_button("Sign In")
    end
  end

  def logout
    visit "/users/sign_out"
  end

  def login_with_facebook
    visit '/users/auth/facebook'
  end
end