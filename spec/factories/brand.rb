FactoryBot.define do
  factory :brand do
    name { Faker::Name.name }
    status { Settings.active }
  end
end
