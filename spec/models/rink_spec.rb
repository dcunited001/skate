require 'spec_helper'

describe Rink do
  subject { Factory(:rink) }

  it { should have_one :address }

  it { should belong_to :owner }
  it { should belong_to :owner }

  it { should have_many :role_members }

  it { should validate_presence_of(:name) }

  it 'can set owner and check owner status' do
    subject.is_owner_set?.should be_false

    owner = Factory(:member)
    subject.owner = owner

    subject.is_owner_set?.should be_true
    #TODO: subject.owner_name.should be owner.name

    #TODO: assert that owner's homerink is also set?
  end

  it 'can display the owner that is set' do
    pending
  end

  it 'can be converted to json' do
    #is there really any good way to test this?
    pending
  end

  #TODO: there's probably a good way to refactor this with a test helper and possibly methods in the model
  it 'can set the contacted date and status' do
    subject.contacted.should be_false

    today = Date.today
    subject.set_contacted
    subject.contacted.should be_true
    subject.original_contact_date.to_date.should be_close(today, 10)
    subject.last_contact_date.to_date.should be_close(today, 10)

    time_then = subject.last_contact_date
    subject.set_contacted
    subject.contacted.should be_true
    subject.original_contact_date.should be_close(time_then, 10)
    subject.last_contact_date.should > time_then
  end

  it 'can set the verified date and status' do
    subject.verified.should be_false

    today = Date.today
    subject.set_verified
    subject.verified.should be_true
    subject.original_verified_date.to_date.should be_close(today, 10)
    subject.last_verified_date.to_date.should be_close(today, 10)

    time_then = subject.last_contacted_date
    subject.set_verified
    subject.verified.should be_true
    subject.original_verified_date.should be_close(time_then, 10)
    subject.last_verified_date.should > time_then
  end

  it 'can set the registered date' do
    pending
  end
end