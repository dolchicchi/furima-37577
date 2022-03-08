FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end

    nickname              { Faker::Name.name }
    email                 { Faker::Internet.free_email }
    password              { Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1) }
    password_confirmation { password }
    last_name             { person.last.kanji }
    first_name            { person.first.kanji }
    kana_last_name        { person.last.katakana }
    kana_first_name       { person.first.katakana }
    birthday              { Faker::Date.between(from: '1930-01-1', to: Date.today) }
  end
end
