FactoryBot.define do
  factory :content do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    category { %w[game video artwork music].sample }
    thumbnail_url { Faker::Internet.url }
    content_url { Faker::Internet.url }
  end
end
