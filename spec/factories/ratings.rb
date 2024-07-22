FactoryBot.define do
  factory :rating do
    association :user
    association :content
    rating { rand(1..5) }
  end
end
