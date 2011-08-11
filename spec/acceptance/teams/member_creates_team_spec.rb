require File.expand_path(File.dirname(__FILE__) + '/../acceptance_helper')

feature 'Member creates a team' do
  before do
    @member = Factory(:member)

    login_as(@member)
  end

  scenario 'starting from the home page' do

  end

  scenario 'when they are already on a team' do

  end

  scenario 'when they already run a team' do

  end
end