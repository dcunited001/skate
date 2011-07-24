require File.expand_path(File.dirname(__FILE__) + '/../acceptance_helper')

feature 'Guest creates an account' do
  before do
    @member = Factory(:member)
  end

  scenario 'Starting from the home page' do
    visit root_path

    within '.login' do
      click_link 'Register'
    end

    within '#signup' do
      fill_in "Email", :with => 'test_member@example.com'
      fill_in "Password", :with => 'password'
      fill_in "Confirm Password", :with => 'password'

      fill_in "First Name", :with => 'TestMember'
      fill_in "Last Name", :with => 'Lastnaam'
      fill_in "Birthday", :with => 'Birthday'
    end



  end
end