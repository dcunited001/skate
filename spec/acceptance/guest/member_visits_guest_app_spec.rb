require File.expand_path(File.dirname(__FILE__) + '/../acceptance_helper')

# this spec is mainly included to remind me that
#     a user can log out from the main app
#     but not the guest app. need more time.
feature 'Member can browse Sinatra GuestApp' do
  before do
    @member = Factory(:member)

    login_as(@member)
  end

  scenario 'where they can still view GuestApp pages' do
    visit root_path

    #normally i would have the user click the links
    #but i'm not sure i want to link back to the guest app once the user is signed in
    #these are all in here for continuity, just in case the user goes back
    [:features, :mission, :about, :contact].each do |page|
      #(better than writing something 10 times thats probably going to change, right?)
      visit "/#{page.to_s}"

      within 'section.main' do
        page.should have_content(page.to_s.capitalize)
      end
    end
  end

  scenario 'and they can still log out' do
    visit '/features'

    within '.login' do
      click_link 'Log Out'
    end

    within '.login' do
      page.should have_content('Log In')
    end
  end
end