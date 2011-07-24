require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'Guest can browse sinatra app' do
  before do

  end

  context 'Starting from the home page' do
    before do
      visit root_path
    end

    scenario 'Guests can\'t login' do

      guest_member[:email] = 'guest_email@example.com'
      login_as(guest_member)

      within 'Somewhere' do
        page.should have_content('Failure')
      end
    end

    scenario 'Guests can view the Signup page' do
      within 'nav' do
        click 'Register'
      end
    end

    scenario 'Guests can view the features page' do
      within 'nav' do
        click 'Features'
      end

      within 'article.main' do
        page.should have_content('Feature')
      end
    end

    scenario 'Guests can view the About page' do
      within 'nav' do
        click 'About'
      end
    end

    scenario 'Guests can view the Contact page' do
      within 'nav' do
        click 'Contact'
      end
    end

    scenario 'Guests can view the Mission page' do
      within 'nav' do
        click 'Mission'
      end
    end


  end
end