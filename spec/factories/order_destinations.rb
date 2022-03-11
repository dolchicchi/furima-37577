FactoryBot.define do
  factory :order_destination do
    post_code do
      Faker::Lorem.characters(number: 3, min_numeric: 3) + '-' + Faker::Lorem.characters(number: 4, min_numeric: 4)
    end
    region_id     { Faker::Number.between(from: 2, to: 48) }
    city          { Faker::Address.street_name }
    address       { Faker::Address.street_address }
    building_name { Faker::Name.name }
    tel           { Faker::Number.number(digits: 10) }
    token         { Faker::Lorem.characters(number: 20) }
  end
end
