require File.expand_path(File.dirname(__FILE__) + '/../acceptance_helper')

feature 'Guest creates an account' do
  before do
    @member = Factory(:member)
  end

  scenario 'Starting from the guestapp home page' do
    visit root_path

    within '.login' do
      click_link 'Register'
    end

    within '#signup' do
      fill_in "Email", :with => 'test_member@example.com'
      fill_in "Password", :with => 'password'
      fill_in "Confirm Password", :with => 'password'

      fill_in "Alias", :with => 'Alias01234'
      fill_in "First Name", :with => 'TestMember'
      fill_in "Last Name", :with => 'Lastnaam'
      fill_in "Birthday", :with => '2011-02-31'

      fill_in "phone", :with => '3216547890'

      #solve captcha

      click_button 'Sign Up'
    end

    #Email_Spec_Stuff

    page.should have_content 'Great Success!'
  end
end