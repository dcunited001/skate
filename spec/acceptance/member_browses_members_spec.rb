require File.expand_path(File.dirname(__FILE__) + '/../acceptance_helper')

feature 'Member browses members: ' do
  before do
    @member = Factory(:member)

    #create 5 other members
    @other_members = (1..5).each_with_object(Array.new) {|i,members| members << Factory(:member)}

    @private_member = Factory(:private_member)
  end

  context 'starting from the home page' do
    before do
      login_as(@member)
    end

    scenario 'they can see a paginated list of members, but they can\'t see private members' do
      within 'nav' do
        click_link 'Members'
      end

      @other_members.each do |member|
        within "member-#{member.id}" do
          page.should have_content
        end
      end

      within '.members-list' do
          (page.should_not have_content @private_member)
      end



      #test pagination??


    end
  end
end