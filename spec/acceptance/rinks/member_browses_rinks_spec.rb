require File.expand_path(File.dirname(__FILE__) + '/../acceptance_helper')

feature 'Member browses rinks: ' do
  before do
    @member = Factory(:member)
    @rinks = (1..4).each_with_object(Array.new) {|i,rinks| rinks << Factory(:rink)}

    login_as(@member)
  end

  scenario 'they can view a list of rinks' do
    within 'nav' do
      click_link 'Rinks'
    end

    within '.rinks-list' do
      page.should have_content @rinks.first.name
      page.should have_content @rinks.last.name
    end
  end

  scenario 'they can\'t view rinks that have been marked not visible' do
    @invisible_rink = Factory(:invisible_rink)

    within 'nav' do
      click_link 'Rinks'
    end

    within '.rinks-list' do
      page.should_not have_content @invisible_rink.name
    end
  end

  context 'they can view a rinks profile' do
    before do
      @invisible_rink = Factory(:invisible_rink)

      within 'nav' do
        click_link 'Rinks'
      end
    end

    scenario 'if the rink is visible' do
      within '.rinks-list' do
        click_link @rinks.first.name
      end

      within '.rink-detail' do
        page.should have_content @rinks.first.name
      end
    end

    scenario 'unless the rink is invisible' do
      within '.rinks-list' do
        visit rink_path(@invisible_rink.id)
      end

      within '.rink-detail' do
        page.should have_content "#{@invisible_rink.name} does not have a profile"
      end
    end
  end
end