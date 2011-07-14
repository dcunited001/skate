require 'spec_helper'

describe Friendship do
  it { should belong_to :member_requesting }
  it { should belong_to :member_requested }

  before do
    @member_sent_request_by_subject_one = Factory(:member)
    @member_sent_request_by_subject_two = Factory(:member)
    @member_sent_request_by_another_member = Factory(:member)
    @member_sent_request_to_another_member = Factory(:member)
    @member_sent_request_to_subject = Factory(:member)
    @member_sent_no_requests = Factory(:member)

    @request_sent_by_subject_one = Factory(:friendship, :member_requesting => subject , :member_requested => @member_sent_request_by_subject_one)
    @request_sent_by_subject_two = Factory(:friendship, :member_requesting => subject , :member_requested => @member_sent_request_by_subject_two)

    @request_sent_to_another_member = Factory(:friendship, :member_requesting => @member_sent_request_to_another_member, :member_requested => @member_sent_request_by_subject_two)
    @request_sent_to_another_member_two = Factory(:friendship, :member_requesting => @member_sent_request_by_subject_one, :member_requested => @member_sent_request_by_subject_two)
    @request_sent_to_subject = Factory(:friendship, :member_requesting => @member_sent_request_to_subject, :member_requested => subject)

    @friend_member_sent_by_subject = Factory(:member)
    @friend_member_sent_to_subject = Factory(:member)
    @member_not_friends_anymore = Factory(:member)

    @friend_sent_by_subject = Factory(:friend, :member_requesting => subject , :member_requested => @friend_member_sent_by_subject)
    @friend_sent_to_subject = Factory(:friend, :member_requesting => @friend_member_sent_to_subject , :member_requested => subject)
    @not_friends_anymore = Factory(:friend, :member_requesting => @member_not_friends_anymore , :member_requested => subject, :rejected => true, :active => false)
  end

  context 'Request Rules' do
    before do

    end

    it 'validates if the member requested is already friends with the requestor' do
      @request_sent_by_subject_one.valid?.should be_true

      @request_sent_by_subject_one.member_requested = @friend_member_sent_by_subject
      @request_sent_by_subject_one.valid?.should be_false

      @request_sent_by_subject_one.member_requested = @member_not_friends_anymore
      @request_sent_by_subject_one.valid?.should be_true
    end

    it "knows if the member requested is already requested by the requestor" do
      @request_sent_by_subject_one.valid?.should be_true

      @request_sent_by_subject_one.member_requested = @member_sent_request_to_another_member
      @request_sent_by_subject_one.valid?.should be_true

      @request_sent_by_subject_one.member_requested = subject
      @request_sent_by_subject_one.valid?.should be_false

      @request_sent_by_subject_one.member_requested = @member_sent_request_to_subject
      @request_sent_by_subject_one.valid?.should be_false
    end

    it 'knows if the member is trying to request itself' do
      @request_sent_by_subject_one.valid?.should be_true

      @request_sent_by_subject_one.member_requested = subject
      @request_sent_by_subject_one.valid?.should be_false
    end
  end

  it 'can be approved' do
    @request_sent_by_subject_one.active.should be_false
    @request_sent_by_subject_one.approved.should be_false

    @request_sent_by_subject_one.approve

    @request_sent_by_subject_one.active.should be_true
    @request_sent_by_subject_one.approved.should be_true
  end

  it 'can be rejected' do
    @request_sent_by_subject_one.active.should be_false
    @request_sent_by_subject_one.rejected.should be_false

    @request_sent_by_subject_one.approve

    @request_sent_by_subject_one.active.should be_false
    @request_sent_by_subject_one.rejected.should be_false
  end

  it 'can be ended' do
    @request_sent_by_subject_one.active.should be_true
    @request_sent_by_subject_one.approved.should be_true
    @request_sent_by_subject_one.rejected.should be_false

    @friend_sent_by_subject.end_friendship

    @request_sent_by_subject_one.active.should be_false
    @request_sent_by_subject_one.approved.should be_true
    @request_sent_by_subject_one.rejected.should be_true
  end
end