module HelperMethods
  #def fill_in_registration_form_for_player(player_attributes = {})
  #  player = Factory.attributes_for(:player, player_attributes)
  #
  #  fill_in 'First Name', :with => player[:first_name]
  #  fill_in 'Last Name', :with => player[:last_name]
  #  select(@school.name_with_city, :from => 'player_registration_school_id')
  #  select(player[:birthday].year.to_s, :from => 'player_registration_player_attributes_birthday_1i')
  #  select('June', :from => 'player_registration_player_attributes_birthday_2i')
  #  select(player[:birthday].day.to_s, :from => 'player_registration_player_attributes_birthday_3i')
  #  select(player[:gender], :from => 'Gender')
  #  select(@shirt_size.label, :from => 'Shirt Size')
  #  select(@grade.label, :from => 'Grade')
  #  fill_in 'Coach Request', :with => 'John Madden'
  #  fill_in 'Buddy Request', :with => 'Bill from San Dimas High School'
  #  select(@division.name_with_age_range, :from => 'Division')
  #end
end

RSpec.configuration.include HelperMethods, :type => :acceptance