FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'Password123' }
    trait :with_password_digest do
      after(:create) do |user|
        user.password_digest = BCrypt::PasswordCreate(user.password)
      end
    end
  end
end
