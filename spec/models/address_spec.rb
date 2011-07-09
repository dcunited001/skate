require 'spec_helper'

describe Address do
  subject { Factory(:address) }

  it { should belong_to :addressable }

  it { should validate_presence_of(:zip) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:line_one) }

  it "is valid with valid attributes" do
    subject.should be_valid
  end

  it "requires that the state be a two letter abbreviation" do
    subject.state = "VA"
    subject.should be_valid

    subject.state = "Virginia"
    subject.should_not be_valid
  end

  it "requires the zip code to be all numbers" do
    subject.zip = 'blahb'
    subject.should_not be_valid
  end

  it "requires the zip code to be 5 digits" do
    subject.zip = '123456'
    subject.should_not be_valid

    subject.zip = '1234'
    subject.should_not be_valid

    subject.zip = '12345'
    subject.should be_valid
  end

  it "accepts 9 digit zip-codes as well" do
    subject.zip = '12345-6789'
    subject.should be_valid

    subject.zip = '123456789'
    subject.should be_valid

    subject.zip = '12345-67890'
    subject.should_not be_valid

    subject.zip = '1234567890'
    subject.should_not be_valid
  end

  describe "to_s" do
    it "prints out the string in a readable format" do
      subject.line_one = '123 Test St.'
      subject.city = 'Testtown'
      subject.state = 'AL'
      subject.zip = '90210'
      subject.to_s.should == "123 Test St. Testtown, AL 90210"

      subject.line_two = '#123'
      subject.to_s.should == "123 Test St. #123 Testtown, AL 90210"
    end
  end
end