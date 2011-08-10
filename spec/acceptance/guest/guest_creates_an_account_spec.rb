require File.expand_path(File.dirname(__FILE__) + '/../acceptance_helper')

feature 'Guest creates an account' do
  before do
    @member = Factory(:member)
  end

  scenario 'Starting from the guestapp home page' do
    visit root_path

    within to_class(DeviseNames::DEVISE_LINKS_CLASS) do
      click_link DeviseNames::REGISTER_LINK_TEXT
    end

    test_member = {
        :email => 'test_member@example.com',
        :password => 'password',

        :alias => 'Alias01234',
        :first_name => 'Testmember',
        :last_name => 'Lastnaam',
        :phone => '3216547890',
        :birthday => '2011-02-31',

        :line_one => '4200 Streety Lane',
        :line_two => 'Number B',
        :city => 'Placelandvilliton',
        :state => 'HI',
        :zip => 90013 }

    within to_id(DeviseNames::SIGN_UP_FORM_ID) do
      fill_in "Email", :with => test_member[:email]
      fill_in "Password", :with => test_member[:password]
      fill_in "Confirm Password", :with => test_member[:password]

      fill_in "Alias", :with => test_member[:alias]
      fill_in "First Name", :with => test_member[:first_name]
      fill_in "Last Name", :with => test_member[:last_name]
      fill_in "Phone", :with => test_member[:phone]
      fill_in "Birthday", :with => test_member[:birthday]

      fill_in "Line One", :with => test_member[:line_one]
      fill_in "Line Two", :with => test_member[:line_two]
      fill_in "City", :with => test_member[:city]
      fill_in "State", :with => test_member[:state]
      fill_in "Zip", :with => test_member[:zip]

      click_button DeviseNames::SIGN_UP_LINK_TEXT
    end

    page.should have_content 'Welcome! You have signed up successfully.'

    click_link test_member[:first_name].capitalize

    within '.member-detail' do
      page.should have_content test_member[:alias]
      page.should have_content test_member[:first_name]
      page.should have_content test_member[:state]
    end

    pending 'verify that the newest member has the correct address, phone and birthday'
  end
end