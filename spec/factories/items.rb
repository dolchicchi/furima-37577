FactoryBot.define do
  factory :item do
    name             { Faker::Name.name }
    explanation      { Faker::Lorem.characters(number: 40) }
    category_id      { Faker::Number.between(from: 2, to: 11) }
    status_id        { Faker::Number.between(from: 2, to: 7) }
    postage_id       { Faker::Number.between(from: 2, to: 3) }
    region_id        { Faker::Number.between(from: 2, to: 48) }
    days_required_id { Faker::Number.between(from: 2, to: 4) }
    price            { Faker::Number.between(from: 300, to: 9_999_999) }
    association :user
    22
    after(:build) do |item|
      item.image.attach(io: File.open('app/assets/images/flag.png'), filename: 'flag.png')
    end
  end
end
