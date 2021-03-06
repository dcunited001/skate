require 'spec_helper'

describe Member do
  subject { Factory(:member) }

  let(:admin) { Factory(:admin) }

  #it { should have_many :authentications }
  it { should have_many :roles }

  it { should have_one :address }
  it { should belong_to :rink }

  it { should have_many :friends }
  it { should have_many :friend_requests_recd }
  it { should have_many :friend_requests_sent }

  #it {should have_many :teams }
  it { should have_many :team_mates }
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

      subject.assign_role(:appadmin)
      subject.is_appadmin?.should be_true
    end

    context 'adding and removing roles' do
      before do
        @team_creator = Factory(:member)
        @team = Factory(:team, :creator => @team_creator)
      end

      it 'can assign new roles' do
        subject.is_appadmin?.should be_false

        subject.assign_role(:appadmin)
        subject.is_appadmin?.should be_true

        subject.is_teamcreator_of?(@team).should be_false

        subject.assign_role(:teamcreator, @team)
        subject.is_teamcreator_of?(@team).should be_true
      end

      it 'can remove roles' do
        subject.is_appadmin?.should be_false

        subject.assign_role(:appadmin)
        subject.is_appadmin?.should be_true

        subject.remove_role(:appadmin)
        subject.is_appadmin?.should be_false

        @team_creator.is_teamcreator_of?(@team).should be_true
        @team_creator.remove_role(:teamcreator, @team)
        @team_creator.is_teamcreator_of?(@team).should be_false
      end
    end

  end

  context 'Rink' do
    it 'knows if the homerink is set or unset' do
      subject.has_rink?.should be_false

      subject.rink = Factory(:rink)
      subject.has_rink?.should be_true
    end

    context 'homerink has been set and' do
      before do
        @rink = Factory(:rink)
        @another_rink = Factory(:rink)
        subject.rink = @rink
      end

      it 'can be set to a new home rink' do
        subject.rink.should equal(@rink)

        subject.rink = @another_rink
        subject.rink.should equal(@another_rink)
      end

      it 'can list other local skaters at that rink' do
        pending #move to rink_spec.rb?
      end

      it 'can list other mutual friends at that rink' do
        pending
      end

      it 'can list other local teams' do
        pending #move to rink_spec.rb?
      end
    end
  end

  context 'With friendships' do
    before(:all) do
      @member_sent_request_by_subject_one = Factory(:member)
      @member_sent_request_by_subject_two = Factory(:member)
      @member_sent_request_by_another_member = Factory(:member)
      @member_sent_request_to_another_member = Factory(:member)
      @member_sent_request_to_subject = Factory(:member)
      @member_sent_no_requests = Factory(:member)
    end

    before(:each) do
      Factory(:friendship, :member_requesting => subject , :member_requested => @member_sent_request_by_subject_one)
      Factory(:friendship, :member_requesting => subject , :member_requested => @member_sent_request_by_subject_two)

      Factory(:friendship, :member_requesting => @member_sent_request_by_subject_one, :member_requested => @member_sent_request_by_subject_two)
      Factory(:friendship, :member_requesting => @member_sent_request_to_another_member, :member_requested => @member_sent_request_by_subject_two)
      Factory(:friendship, :member_requesting => @member_sent_request_to_subject, :member_requested => subject)
    end


    it "knows they are already requested by a member" do
      subject.already_friend_request_from?(@member_sent_request_by_subject_two).should be_false
      subject.already_friend_request_from?(@member_sent_request_to_subject).should be_true
      subject.already_friend_request_from?(@member_sent_no_requests).should be_false
    end

    it 'knows they are already requesting a member' do
      subject.already_friend_request_to?(@member_sent_request_by_subject_one).should be_true
      subject.already_friend_request_to?(@member_sent_request_by_subject_two).should be_true
      subject.already_friend_request_to?(@member_sent_request_to_subject).should be_false
      subject.already_friend_request_to?(@member_sent_no_requests).should be_false
    end

    context 'that are active' do
      before do
        @friend_sent_by_subject = Factory(:member)
        @friend_sent_to_subject = Factory(:member)
        @not_friends_anymore = Factory(:member)

        Factory(:friend, :member_requesting => subject , :member_requested => @friend_sent_by_subject)
        Factory(:friend, :member_requesting => @friend_sent_to_subject , :member_requested => subject)
        Factory(:friend, :member_requesting => @not_friends_anymore , :member_requested => subject, :rejected => true, :active => false)
      end

      it 'knows whether it is friend requestable' do
        subject.friend_requestable?(@member_sent_request_to_another_member).should be_true
        subject.friend_requestable?(@not_friends_anymore).should be_true
        subject.friend_requestable?(@member_sent_no_requests).should be_true

        subject.friend_requestable?(@friend_sent_by_subject).should be_false
        subject.friend_requestable?(@friend_sent_to_subject).should be_false
        subject.friend_requestable?(@member_sent_request_by_subject_one).should be_false
        subject.friend_requestable?(@member_sent_request_to_subject).should be_false
      end

      it 'knows they are already friends with a member' do
        subject.already_friends_with?(@member_sent_request_by_subject_one).should be_false
        subject.already_friends_with?(@member_sent_request_to_subject).should be_false
        subject.already_friends_with?(@member_sent_request_to_another_member).should be_false

        subject.already_friends_with?(@friend_sent_by_subject).should be_true
        subject.already_friends_with?(@friend_sent_to_subject).should be_true
        subject.already_friends_with?(@not_friends_anymore).should be_false
      end

      it 'should list the correct friends' do
        subject.friends.should include(@friend_sent_by_subject)
        subject.friends.should include(@friend_sent_to_subject)

        subject.friends.should_not include(@not_friends_anymore)
        subject.friends.should_not include(@member_sent_request_by_subject_one)
        subject.friends.should_not include(@member_sent_request_to_subject)
      end

      it 'can delete friends from its list' do
        subject.friends.should include(@friend_sent_by_subject)
        subject.friends.should include(@friend_sent_to_subject)
        subject.friends.should_not include(@not_friends_anymore)

        deleted_friend = subject.friends.first
        subject.friends.should include(deleted_friend)

        deleted.friend.delete
        subject.friends.should_not include(deleted_friend)
      end

      it 'can tell when friends are equal' do
        pending
      end

      it 'should list the correct mutual friends' do
        pending
      end

      it 'knows if they are mutually friends with another member through a friend' do
        pending
      end
    end

  end

  context 'on a Team' do
    before do
      @team = Factory(:team)

      @team_creator = Factory(:member)
      @team_captain = Factory(:member)
    end

    it 'knows if they are on a team' do
      subject.has_team?.should be_false

      Factory(:team_member, :member_requesting => @team_creator, :member_requested => subject)
      subject.has_team?.should be_true
    end

    it 'knows if it\'s the captain of a team' do
      pending
    end

    it 'knows if it\'s the creator of a team' do
      pending
    end

    context 'with Team Requests' do
      before(:all) do
        @team = Factory(:team, :creator => subject)

        @another_team_creator = Factory(:member)
        @another_team = Factory(:team, :creator => @another_team_creator)

        @yet_another_team = Factory(:team)
      end

      before(:each) do
        @member_sent_request_by_subject_one = Factory(:member)
        @member_sent_request_by_subject_two = Factory(:member)
        @member_sent_request_by_subject_for_another_team = Factory(:member)
        @member_sent_request_by_another_member = Factory(:member)
        @member_sent_request_to_another_member = Factory(:member)
        @member_sent_request_to_subject = Factory(:member)
        @member_sent_request_to_subject_for_another_team = Factory(:member)
        @member_sent_no_requests = Factory(:member)

        Factory(:team_request, :member_requesting => subject, :member_requested => @member_sent_request_by_subject_one, :team => @team)
        Factory(:team_request, :member_requesting => subject, :member_requested => @member_sent_request_by_subject_two, :team => Factory(:team))
        Factory(:team_request, :member_requesting => @member_sent_request_to_another_member, :member_requested => @member_sent_request_by_subject_two, :team => @team)
        Factory(:team_request, :member_requesting => @member_sent_request_by_subject_one, :member_requested => @member_sent_request_by_subject_two, :team => @another_team)
        Factory(:team_request, :member_requesting => @member_sent_request_to_subject, :member_requested => subject, :team => Factory(:team))
        Factory(:team_request, :member_requesting => @member_sent_request_to_subject_for_another_team, :member_requested => subject, :team => @another_team)
        Factory(:team_request, :member_requesting => subject, :member_requested => @member_sent_request_by_subject_for_another_team, :team => Factory(:team))
      end

      it 'knows if it is team-requestable' do
        pending 'implementation of Member team request methods'

        subject.team_requestable?(@team, @member_sent_request_by_subject_one).should be_false
        subject.team_requestable?(@team, @member_sent_request_by_subject_two).should be_true

        subject.team_requestable?(@team)
      end

      it 'knows if it has an open team request from a specific member or team or both' do
        pending 'implementation of Member team request methods'

        # subject was sent a request to be on @another team from @member_sent_request_to_subject_for_another_team
        subject.already_team_request_from?(@another_team).should be_true
        subject.already_team_request_from?(@member_sent_request_to_subject_for_another_team).should be_true
        subject.already_team_request_from?(@member_sent_request_to_subject_for_another_team, @another_team).should be_true
        subject.already_team_request_from?(@member_sent_request_to_subject_for_another_team, @yet_another_team).should be_false
        subject.already_team_request_from?(@another_team, @member_sent_request_to_subject_for_another_team).should be_true  #order of params should not matter
        subject.already_team_request_from?(@member_sent_request_to_subject_for_another_team, @yet_another_team).should be_false
        subject.already_team_request_from?(@yet_another_team, @member_sent_request_to_subject_for_another_team).should be_false  #order of params should not matter

        @member_sent_request_to_subject_for_another_team.already_team_request_from?(subject).should be_false
        @member_sent_request_to_subject_for_another_team.already_team_request_from?(subject, @another_team).should be_false
        @member_sent_request_to_subject_for_another_team.already_team_request_from?(@another_team).should be_false

        # @member_sent_request_by_subject_one was sent a request by the subject to be on the subjects team
        @member_sent_request_by_subject_one.already_team_request_from?(subject).should be_true
        @member_sent_request_by_subject_one.already_team_request_from?(subject, @team).should be_true
        @member_sent_request_by_subject_one.already_team_request_from?(@team, subject).should be_true
        subject.already_team_request_from?(@member_sent_request_by_subject_one).should be_false
        subject.already_team_request_from?(@member_sent_request_by_subject_one, @team).should be_false
        subject.already_team_request_from?(@team, @member_sent_request_by_subject_one).should be_false  #????? subject is already on this team, should be false bc its not pending

        #subject was sent a request from this member to be on a generic team
        subject.already_team_request_from?(@member_sent_request_to_subject).should be_true
        subject.already_team_request_from?(@member_sent_request_to_subject, @another_team).should be_false

      end

      it 'knows if it has an open team request from a specific team' do
        pending 'implementation of Member team request methods'

        #request from the subject's own team
        subject.already_request_from?(@team).should be_true

        #subject was sent a request from this member, but it was not for @another_team
        subject.already_team_request_from?(@member_sent_request_to_subject).should be_false

        #this member was sent a request by the subject to be on the subjects team
        @member_sent_request_by_subject_one.already_team_request_from?(subject).should be_true
        @member_sent_request_by_subject_one.already_team_request_from?(subject).should be_true
        subject.already_team_request_from?(@member_sent_request_by_subject_one).should be_false
      end

      it 'knows if it has an open team request to a specific team' do
        pending 'implementation of Member team request methods'
      end

      it 'knows if it is already on a specific team' do
        pending 'need to implement the team relationship for a member'
      end

      it 'can list all pending sent team requests' do
        pending
      end

      it 'can list all pending received team requests' do
        pending
      end

      context 'that are active' do

      end
    end
  end
end