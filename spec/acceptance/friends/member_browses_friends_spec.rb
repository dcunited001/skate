require File.expand_path(File.dirname(__FILE__) + '/../acceptance_helper')

feature 'Member browses friends: ' do
  before do
    @member = Factory(:member)
    @other_members = (1..5).each_with_object(Array.new) {|i,members| members << Factory(:member)}

    @private_member = Factory(:private_member)

    login_as(@member)
  end

  context 'they can see a list of their friends' do
    before do
      click_link 'Friends'
    end

    scenario 'including public members' do
      pending 'Need to finish writing set up (most of it will come from friendship spec) '
    end

    scenario 'including private members' do
      pending 'Need to finish writing set up (most of it will come from friendship spec) '
    end

    scenario 'not including pending friends' do
      #create some pending friends

      pending 'Need to finish writing set up (most of it will come from friendship spec) '
    end

    scenario 'not including former friends' do
      #create some friends and remove the relationships

      pending 'Need to finish writing set up (most of it will come from friendship spec) '
    end
  end

end