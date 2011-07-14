require 'spec_helper'

describe Friendship do
  it { should belong_to :member_requesting }
  it { should belong_to :member_requested }

  let(:mem1) { Factory(:member) }
  let(:mem2) { Factory(:member) }
  let(:mem3) { Factory(:member) }
  let(:mem4) { Factory(:member) }

  context 'Request Rules' do
    before do

    end

    it 'validates if the member requested is already friends with the requestor' do
      pending
    end

    it "knows if the member requested is already requested by the requestor" do
      pending
    end

    it 'knows if the member is trying to request itself' do
      pending
    end
  end

  context 'Request Action Helpers' do
    before do

    end

    it 'can be approved if valid' do
      pending #necessary to check validity at this stage?
    end

    it 'can be rejected if valid' do
      pending
    end
  end
end