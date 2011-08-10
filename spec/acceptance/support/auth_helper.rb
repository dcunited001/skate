module AuthHelper
  def login_as(member)
    #this needs to be changed to a modal javascript

    visit "/login"
    within to_id(DeviseNames::SIGN_IN_FORM_ID) do
      fill_in("member[email]", :with => member[:email])
      fill_in("member[password]", :with => 'password')
      click_button(DeviseNames::SIGN_IN_LINK_TEXT)
    end
  end

  def create_account(member)
    within to_id(DeviseNames::SIGN_UP_FORM_ID) do
      fill_in "Email", :with => member[:email]
      fill_in "Password", :with => member[:password]
      fill_in "Confirm Password", :with => member[:password]

      fill_in "Alias", :with => member[:alias]
      fill_in "First Name", :with => member[:first_name]
      fill_in "Last Name", :with => member[:last_name]
      fill_in "Phone", :with => member[:phone]
      fill_in "Birthday", :with => member[:birthday]

      fill_in "Line One", :with => member[:line_one]
      fill_in "Line Two", :with => member[:line_two]
      fill_in "City", :with => member[:city]
      fill_in "State", :with => member[:state]
      fill_in "Zip", :with => member[:zip]

      click_button DeviseNames::SIGN_UP_LINK_TEXT
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