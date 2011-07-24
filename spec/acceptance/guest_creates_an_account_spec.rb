require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'Guest creates an account' do
  before do
    @member = Factory(:member)
  end

  scenario 'Starting from the home page' do
    visit root_path

    within '.login-or-register' do
      click_link 'Register'
    end



  end
end