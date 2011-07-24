require 'spec_helper'

describe Region do
  subject {Factory(:region)}

  it { should have_many :states }
  it { should have_many :region_states }


  context 'Addresses: Regions' do
    before do
      #create some objects with addresses
    end

    it 'can tell if an address is within it' do
      pending
    end

    it 'can list all the addresses within that region' do
      pending
    end

    it 'can list all the devise with an address in that region' do
      pending
    end

    it 'can list all the rinks with and address in that region' do
      pending
    end
  end
end