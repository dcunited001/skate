require 'spec_helper'

describe Rink do
  subject { Factory(:rink) }

  it { should have_one :address }

  it { should belong_to :owner }
  it { should belong_to :contact }

  it { should validate_presence_of(:name) }

  context ' - Owner and Contact - ' do
    before do
      #create some devise
      @owner_name = 'Owner McDude'
      @contact_name = 'Rink O\'Manager'

      @owner = Factory(:member, :first_name => @owner_name.split(' ')[0], :last_name => @owner_name.split(' ')[1])
      @contact = Factory(:member, :first_name => @contact_name.split(' ')[0], :last_name => @contact_name.split(' ')[1])
    end

    it 'can set the owner' do
      subject.get_owner_name.should == Rink::DEFAULT_MISSING_OWNER_NAME
      subject.owner = "new owner"
      subject.get_owner_name.should == "new owner"
      subject.owner = @owner
      subject.get_owner_name.full_name.should == @owner_name
    end

    it 'can set the contact' do
      subject.get_contact_name.should == Rink::DEFAULT_MISSING_CONTACT_NAME
      subject.contact = "new contact"
      subject.get_contact_name.should == "new contact"
      subject.contact = @contact
      subject.get_contact_name.full_name.should == @contact_name
    end

    it 'know if it has an owner set and if it has an owner member set' do
      subject.is_owner_set?.should be_false
      subject.owner_name_set?.should be_false

      subject.owner_name = 'Some Owner'
      subject.owner_name_set?.should be_true
      subject.is_owner_set?.should be_true

      subject.owner = @owner
      subject.owner_name_set?.should be_false
      subject.is_contact_set?.should be_true
    end

    it 'know if it has a contact set or if it has a contact member set' do
      subject.is_contact_set?.should be_false
      subject.contact_name_set?.should be_false

      subject.contact_name = 'Some Contact'
      subject.contact_name_set?.should be_true
      subject.is_contact_set?.should be_true

      subject.contact = @contact
      subject.contact_name_set?.should be_false
      subject.is_contact_set?.should be_true
    end
  end

  context 'Skaters' do
    before(:all) do
      @another_rink = Factory(:rink)

      @skater_one = Factory(:member, :rink => subject)
      @skater_two = Factory(:member, :rink => subject)
      @skater_three = Factory(:member, :rink => subject)

      @another_rink_skater_one = Factory(:member, :rink => @another_rink)
      @another_rink_skater_two = Factory(:member, :rink => @another_rink)

      #set up some friend relationships between the users
    end

    it 'can list the members who consider this their home rink' do
      #this test really isnt necessary

      subject.skaters.should include(@skater_one)
      subject.skaters.should include(@skater_two)
      subject.skaters.should_not include(@another_rink_skater_one)
      subject.skaters.count.should be(3)

      @another_rink.skaters.should include(@another_rink_skater_one)
      @another_rink.skaters.should_not include(@skater_one)
      @another_rink.skaters.count.should be(2)
    end

    it 'can list a members mutual friends who consider this their home rink' do
      pending 'create Rink.mutual_members(member) method'
    end
  end

  context 'Contacted Date' do
    before do
      #Delorean/Timecop setup?
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
  end

  context 'Verified Date' do
    before do
      #Delorean/Timecop setup?
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
  end

  context 'Registered Date' do
    before do
      #Delorean/Timecop setup?
    end

    it 'can set the registered date' do
      pending
    end
  end

  it 'can be converted to json' do
    #is there really any good way to test this?
    pending
  end
end