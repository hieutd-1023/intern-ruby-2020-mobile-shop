FactoryBot.define do
  factory :product do
    name { Faker::Name.name }
    amount { Faker::Number.within(range: 1..Settings.max) }
    price { Faker::Number.within(range: 1..Settings.max) }
    description { Faker::Lorem.paragraph }
    status { "active" }

    association :brand
    association :category
  end
end
