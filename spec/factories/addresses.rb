

CITY_TO_ZIP_HASH = {
    'Norfolk' => '23511',
    'Roanoke' => '24012',
    'Salem' => '24153' }

Factory.define(:address, :class => 'Address') do |address|
  address.sequence(:line_one) { |n| "#{n} Streety Lane"}
  address.city { %w(Norfolk Roanoke Salem).sample }
  address.state { %w(VA NC SC).sample}
  address.zip { |a| CITY_TO_ZIP_HASH[a.city] }
end

Factory.define(:apartment_address, :parent => :address) do |address|
  address.sequence(:line_two) { |n| "#10#{n}"}
end

Factory.define(:geo_address, :parent => :address) do |address|
  address.latitude (rand(360) - 180)
  address.longitude (rand(180) - 90)
end

