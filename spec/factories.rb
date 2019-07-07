FactoryBot.define do
  factory :login_user, class: User do
    password = Faker::Internet.password(8)
    name { Faker::Name.last_name }
    email { Faker::Internet.free_email }
    password { password }
    password_confirmation { password }
    
    after(:create) do |user|
      group = Group.create(
        user_id: user.id,
        name: "User Group",
        note: "Users Note"
      )
      member = Member.create(
        user_id: user.id,
        group_id: group.id,
      )
      space = Space.create(
        group_id: group.id,
        start_at: DateTime.now,
        end_at: DateTime.now + 1.hour,
        note: "時間厳守で集まってくださいね^^;"
      )
    end
  end
  
  factory :admin_user, class: User do
    password = Faker::Internet.password(8)
    name { Faker::Name.last_name }
    email { Faker::Internet.free_email }
    password { password }
    password_confirmation { password }
    admin { true }
  end
  
  factory :other_user, class: User do
    password = Faker::Internet.password(8)
    name { Faker::Name.last_name }
    email { Faker::Internet.free_email }
    password { password }
    password_confirmation { password }
    after(:create) do |user|
      group = Group.create(
        user_id: user.id,
        name: "Other User Group",
        note: "Other Users Note"
      )
      member = Member.create(
        user_id: user.id,
        group_id: group.id,
        admin: true
      )
      space = Space.create(
        group_id: group.id,
        start_at: DateTime.now,
        end_at: DateTime.now + 1.hour,
        note: "時間厳守で集まってくださいね^^;"
      )
    end
  end
end
