FactoryBot.define do
  factory :group do
    name { "MyString" }
    note { "MyText" }
  end

  factory :members_role do
    member { nil }
    role { nil }
  end

  factory :reservation do
    space { nil }
    start_at { "2019-07-06 19:23:49" }
    end_at { "2019-07-06 19:23:49" }
    note { "MyText" }
  end

  factory :member do
    user { nil }
    group { nil }
  end

  factory :space do
    group { nil }
    start_at { "2019-07-06 19:15:04" }
    end_at { "2019-07-06 19:15:04" }
    note { "MyText" }
  end

  factory :login_user, class: User do
    password = Faker::Internet.password(8)
    name { Faker::Name.last_name }
    email { Faker::Internet.free_email }
    password { password }
    password_confirmation { password }
  end
  
  factory :admin_user, class: User do
    password = Faker::Internet.password(8)
    name { Faker::Name.last_name }
    email { Faker::Internet.free_email }
    password { password }
    password_confirmation { password }
  end
  
  factory :other_user, class: User do
    password = Faker::Internet.password(8)
    name { Faker::Name.last_name }
    email { Faker::Internet.free_email }
    password { password }
    password_confirmation { password }
  end
end
