ABBREV_TO_STATE_HASH = {
    'VA' => 'Virginia',
    'CA' => 'California',
    'FL' => 'Florida'
}

Factory.define(:state, :class => 'State') do |state|
  state.abbrev (ABBREV_TO_STATE_HASH.keys.sample)
  state.name
end