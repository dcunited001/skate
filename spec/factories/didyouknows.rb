Factory.define(:dyk, :class => 'Didyouknow') do |dyk|
  dyk.message (lorem(20) + '??  OMFGLoloL')
  dyk.submitted_by { |d| d.association(:member) }
  dyk.rate rand(100)
  dyk.approved false
end

Factory.define(:approved_dyk, :parent => :dyk) do |dyk|
  dyk.approved true
  dyk.approved_by { |d| d.association(:admin) }
end