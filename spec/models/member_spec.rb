require 'spec_helper'

describe Member do
  subject { Factory(:member) }

  let(:admin) { Factory(:admin) }

  #it { should have_many :authentications }
  it { should have_many :roles }

  it { should have_one :address }
  it { should belong_to :rink }

  #it { should have_many :friends }
  it { should have_many :friend_requests_recd }
  it { should have_many :friend_requests_sent }

  #it {should have_many :teams }
  #it {should have_many :team_members }
  it { should have_many :team_requests_recd }
  it { should have_many :team_requests_sent }

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }

  context 'Helpers' do
    it 'should return the first and last name of the member' do
      member = Factory(:member, :first_name => 'Johnny', :last_name => 'Cage')
      member.full_name.should == 'Johnny Cage'
    end
  end

  #context 'Roleable Roles' do # and potent potables
  context 'App Roles' do
    it 'can tell you if it\'s a member' do
      subject.is_appuser?.should be_true
      subject.is_appadmin?.should_not be_true
    end

    it 'can tell you if it\'s an admin' do
      admin.is_appuser?.should be_true
      admin.is_appadmin?.should be_true

      subject.is_appadmin?.should_not be_true
    end
  end

  context 'Rink' do
    it 'can be determined homerink to be set or unset' do
      subject.has_rink?.should be_false

      subject.rink = Factory(:rink)
      subject.has_rink?.should be_true
    end

    context 'homerink has been set and' do
      before do
        @rink = Factory(:rink)
        subject.rink = @rink
      end

      it 'can be set to a new home rink' do
        subject.rink.should equal(@rink)

        another_rink = Factory(:rink)
        subject.rink = another_rink
        subject.rink.should equal(another_rink)
      end

      it 'can list other mutual friends at that rink' do
        pending
      end

      it 'can list other local skaters at that rink' do
        pending #move to rink_spec.rb?
      end

      it 'can list other local teams' do
        pending #move to rink_spec.rb?
      end
    end
  end

  context 'With friendships' do
    before do
      @member_sent_request_by_subject_one = Factory(:member)
      @member_sent_request_by_subject_two = Factory(:member)
      @member_sent_request_by_another_member = Factory(:member)
      @member_sent_request_to_subject = Factory(:member)
      @member_sent_no_requests = Factory(:member)

      @friend_sent_by_subject = Factory(:member)
      @friend_sent_to_subject = Factory(:member)
      @not_friends_anymore = Factory(:member)


      Factory(:friendship, :member_requesting => subject , :member_requested => @member_sent_request_by_subject_one)
      Factory(:friendship, :member_requesting => subject , :member_requested => @member_sent_request_by_subject_two)

      Factory(:friendship, :member_requesting => @member_sent_request_by_subject_one, :member_requested => @member_sent_request_by_subject_two)
      Factory(:friendship, :member_requesting => @member_sent_request_to_subject, :member_requested => subject)

      Factory(:friend, :member_requesting => subject , :member_requested => @friend_sent_by_subject)
      Factory(:friend, :member_requesting => @friend_sent_to_subject , :member_requested => subject)
      Factory(:friend, :member_requesting => @not_friends_anymore , :member_requested => subject, :rejected => true, :active => false)
    end

    it 'knows they are already friends with a member' do
      subject.already_friends_with(@friend_sent_by_subject).should be_true
      subject.already_friends_with(@friend_sent_to_subject).should be_true
      subject.already_friends_with(@not_friends_anymore).should be_false

      #pending friend requests don't count
      #rejected friend requests don't count
      #accepted friend requests that aren't active don't count
      #active friend requests do count
    end

    it "knows they are already requested by a member" do
      subject.already_friend_request_from(@member_sent_request_by_subject_two).should be_false
      subject.already_friend_request_from(@member_sent_request_to_subject).should be_true
      subject.already_friend_request_from(@member_sent_no_requests).should be_false
    end

    it 'knows they are already requesting a member' do
      subject.already_friend_request_to(@member_sent_request_by_subject_one).should be_true
      subject.already_friend_request_to(@member_sent_request_by_subject_two).should be_true
      subject.already_friend_request_to(@member_sent_request_to_subject).should be_false
      subject.already_friend_request_to(@member_sent_no_requests).should be_false
    end

    it 'knows if they are mutually friends with another member through a friend' do
      pending
    end
  end

  context 'on a Team' do
    before do
      #set up some teams
    end

    it 'knows if they are on a team' do
      pending
    end

    it 'knows if it\'s the captain of a team' do
      pending
    end

    it 'knows if it\'s the creator of a team' do
      pending
    end
  end

  context 'with Team Requests' do
    before do

    end

    it 'knows if it is team-requestable' do
      pending
    end

    it 'knows if it has an open team request from a specific member' do
      pending
    end

    it 'knows if it has an open team request from a specific team' do
      pending
    end

    it 'knows if it has an open team request to a specific team' do
      pending
    end

    it 'can list all pending sent team requests' do
      pending
    end

    it 'can list all pending received team requests' do
      pending
    end
  end

  context 'Friends' do
    before do

    end

    it 'can list all current friends' do
      pending
    end

    it 'lists all pending sent friend requests' do
      pending
    end

    it 'lists all pending received friend requests' do
      pending
    end

    context 'Friend Requests' do
      it 'knows if it is friend-requestable' do
        pending
      end

      it 'knows if you are already friends' do
        pending
      end

      it 'knows if you have already sent a friend request' do
        pending
      end
    end
  end
end