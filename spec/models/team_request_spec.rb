require 'spec_helper'

describe TeamMember do
  it { should belong_to :member_requesting }
  it { should belong_to :member_requested }

  it { should belong_to :team }

  context 'Request Rules' do
    before do
      @member = Factory(:member)

      @team_creator = Factory(:team_creator)
      @team_member = Factory(:team_member, :team => @team_creator.team)
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

  context 'Request Scopes' do
    context 'Pending, Accepted, Rejected Requests' do
      before(:each) do
        #@skater_pending_from_jammers = Factory(:member); Factory(:team_request, :team => @jammers_va, :member_requesting => @dcunited,:member_requested => @skater_pending_from_jammers)
        #@skater_pending_to_jammers = Factory(:member); Factory(:team_request, :team => @jammers_va, :member_requesting => @skater_pending_to_jammers,:member_requested => @dcunited)
        #@skater_pending_to_jammers_two = Factory(:member); Factory(:team_request, :team => @jammers_va, :member_requesting => @skater_pending_to_jammers_two,:member_requested => @dcunited)
        #@skater_pending_to_authentic = Factory(:member); Factory(:team_request, :team => @authentic, :member_requesting => @skater_pending_to_authentic ,:member_requested => @james)
        #@skater_not_gonna_be_on_jammers = Factory(:member); Factory(:team_request, :team => @jammers_va, :member_requesting => @skater_not_gonna_be_on_jammers ,:member_requested => @dcunited)
      end

      it 'can list all pending Team Requests' do
        pending 'association implementation'


      end

      it 'can list all accepted Team Requests' do
        pending 'association implementation'
      end

      it 'can list all rejected Team Requests' do
        pending 'association implementation'
      end
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