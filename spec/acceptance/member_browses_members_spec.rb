require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'Member browses members: ' do
  before do
    @member = Factory(:member)
    @other_members = (1..5).each_with_object(Array.new) {|i,members| members << Factory(:member)}

    @private_member = Factory(:private_member)

    login_as(@member)
  end

  scenario 'they can see a list of members, not including themselves' do
    within 'nav' do
      click_link 'Members'
    end

    within ".members-list" do
      within "#member-#{@other_members.first.id}" do
        page.should have_link @other_members.first.alias
      end
      within "#member-#{@other_members.last.id}" do
        page.should have_link @other_members.last.alias
      end
      page.should_not have_content @member.alias
    end

    #@other_members.each do |member|
    #  within "member-#{member.id}" do
    #    page.should have_content member.alias
    #  end
    #end
  end

  scenario 'they can\'t see private members' do
    @private_member = Factory(:private_member)

    within 'nav' do
      click_link 'Members'
    end

    within '.members-list' do
      page.should_not have_content @private_member.alias
    end
  end

  scenario 'they can\'t see private members that they are not mutual friends with' do
    #create some members that are mutual friends of the original member
    #   with different privacy settings
    @friend = Factory(:friend, :member_requesting => @member).member_requested
    @mutual_friend = Factory(:friend, :member_requesting => @friend).member_requested
    @private_mutual_friend = Factory(:friend, :member_requesting => @friend).member_requested
    @private_mutual_friend.set_privacy_visibility(true)

    #mutual_friendships =
    @not_mutual_friend = Factory(:member)
    @private_not_mutual_friend = Factory(:member)
    @private_not_mutual_friend.set_privacy_visibility(true)

    within 'nav' do
      click_link 'Members'
    end

    within '.members-list' do
      page.should have_content @mutual_friend.alias
      page.should have_content @private_mutual_friend.alias
      page.should have_content @not_mutual_friend.alias

      page.should_not have_content @private_not_mutual_friend.alias
    end
  end

  scenario 'but they can still see private members they are not mutual friends with if they are team mates' do
    puts 'fml'
    pending
  end

  context 'they can view a members profile' do
    before do
      within 'nav' do
        click_link 'Members'
      end
    end

    scenario 'if that member is public' do

      within '.members-list' do
        click_link @other_members.first.alias
      end

      within '.member-detail' do
        page.should have_content @other_members.first.name
      end
    end

    scenario 'unless that member is private' do
      within '.members-list' do
        click_link @private_member.alias
      end

      within '.member-detail' do
        page.should have_content "#{@private_member.alias} has a private profile."
      end
    end
  end
end