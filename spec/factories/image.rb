FactoryBot.define do
  factory :image do
    product { FactoryBot.create product }
    description { Faker::Avatar.image }
  end
end
