module AuthHelper
  def login_as(member)
    #this needs to be changed to a modal javascript

    visit "/login"
    within DeviseNames::DEVISE_FORM_CLASS do
      fill_in("member[email]", :with => member[:email])
      fill_in("member[password]", :with => 'password')
      click_button(DeviseNames::SIGN_IN_LINK_TEXT)
    end
  end

  def logout
    visit "/users/sign_out"
  end

  def login_with_facebook
    visit '/users/auth/facebook'
  end
end

RSpec.configuration.include AuthHelper, :type => :acceptance