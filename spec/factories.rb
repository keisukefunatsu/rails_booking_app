FactoryBot.define do
  factory :test_user, class: User do
    password = Faker::Internet.password(8)
    name { Faker::Name.last_name }
    email { Faker::Internet.free_email }
    password { password }
    password_confirmation { password }
  end
end
