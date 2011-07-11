require 'spec_helper'

describe State do
  subject { Factory(:state) }

  it { should have_one :region }
  it { should have_one :region_state }

  it "requires that the state be a two letter abbreviation" do
    subject.state = "VA"
    subject.should be_valid

    subject.state = "Virginia"
    subject.should_not be_valid
  end


  context 'Addresses: States' do
    before do

    end

    it 'can list all the addresses within that state' do
      pending
    end

    it 'can list all the members with an address in that state' do
      pending
    end

    it 'can list all the rinks with and address in that state' do
      pending
    end
  end
end