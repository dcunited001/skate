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

    #assume that the last created member in the table is the one we just created
    test_member_db = Member.order("created_at DESC").last

    #better way to verify that an address was created correctly?
    #   may be better to step through to the edit action of a member,
    #   once this has been implemented
    test_member_db.address.line_one.should_equal test_member[:line_one]
    test_member_db.address.state.should_equal test_member[:state]
    test_member_db.address.city.should_equal test_member[:city]
    test_member_db.address.zip.should_equal test_member[:zip]

    within '.member-detail' do
      page.should have_content test_member[:alias]
      page.should have_content test_member[:first_name]

      puts '===================='
      puts test_member_db.birthday
      puts test_member_db.address
      puts '===================='

      page.should have_content test_member_db.address.real_state.name
    end
  end
end