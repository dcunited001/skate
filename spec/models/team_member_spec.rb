require 'spec_helper'

describe TeamMember do
  it { should belong_to :member_requesting }
  it { should belong_to :member_requested }

  it { should belong_to :team }

  context 'Request Rules' do
    before do

    end

    it 'knows if the member requested is already on a team' do
      pending
    end

    it 'knows if the member requested is already requested by a specific member' do
      pending
    end

    it 'knows if the member requested has already requested to be on a specific team' do
      pending
    end

    it 'knows if the member requested has already received a request to be on a specific team' do
      pending
    end
  end

  context 'Request Action Helpers' do
    before do

    end

    it 'can be approved if valid' do
      #necessary to check validity here because member may have joined a team after the request was sent

      pending
    end

    it 'can be rejected if valid' do
      pending
    end
  end
end