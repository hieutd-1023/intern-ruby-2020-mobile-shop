FactoryBot.define do
  factory :category do
    name { Faker::Name.name }
    category_id { 0 }
    status { Settings.active }
    slug { Faker::Internet.slug(words: name, glue: '-') }
  end
end
