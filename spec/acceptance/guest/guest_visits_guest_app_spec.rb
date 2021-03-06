require File.expand_path(File.dirname(__FILE__) + '/../acceptance_helper')

feature 'Guest can browse sinatra app' do
  before do

  end

  context 'Starting from the home page' do
    before do
      visit root_path
    end

    scenario 'Guests can\'t login' do
      guest_member = { :email => 'guest_email@example.com' }
      login_as(guest_member)

      within '.alert' do
        page.should have_content('Invalid email or password')
      end
    end

    #this is already covered by guest_creates_an_account
    scenario 'Guests can view the Signup page' do
      within to_class(DeviseNames::DEVISE_LINKS_CLASS) do
        click_link DeviseNames::REGISTER_LINK_TEXT
      end

      within to_id(DeviseNames::SIGN_UP_FORM_ID) do
        page.should have_content(DeviseNames::SIGN_UP_LINK_TEXT)
      end
    end

    scenario 'Guests can view the Features page' do
      within 'nav' do
        click_link 'Features'
      end

      within 'section.main' do
        page.should have_content('Features')
      end
    end

    scenario 'Guests can view the About page' do
      within 'nav' do
        click_link 'About'
      end

      within 'section.main' do
        page.should have_content('About')
      end
    end

    scenario 'Guests can view the Contact page' do
      within 'nav' do
        click_link 'Contact'
      end

      within 'section.main' do
        page.should have_content('Contact')
      end
    end

    scenario 'Guests can view the Mission page' do
      within 'nav' do
        click_link 'Mission'
      end

      within 'section.main' do
        page.should have_content('Mission')
      end
    end
  end
end