Factory.define(:region, :class => 'Region') do |region|
  region.sequence(:name) { |n| "Region #{n}" }
  region.sequence(:description) { |n| "Reg Desc #{n}"}
end

