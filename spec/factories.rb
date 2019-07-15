FactoryBot.define do
  factory :login_log do
    token { "MyString" }
  end

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
        note: "Please gather on time!"
      )
      reservation = Reservation.create(
        space_id: space.id,
        member_id: member.id,
        start_at: DateTime.now,
        end_at: DateTime.now + 1.hour,
        note: "I will join!"
      )
      
      # users is in the same group as login_user
      3.times do 
        password = Faker::Internet.password(8)
        user = User.create(
            name: Faker::Name.last_name,
            email: Faker::Internet.free_email,
            password: password,
            password_confirmation: password 
        )
        3.times do
          member = Member.create(
            user_id: user.id,
            group_id: group.id,
          )
          space = Space.create(
            group_id: group.id,
            start_at: DateTime.now,
            end_at: DateTime.now + 1.hour,
            note: "Please gather on time!"
          )
          reservation = Reservation.create(
            space_id: space.id,
            member_id: member.id,
            start_at: DateTime.now,
            end_at: DateTime.now + 1.hour,
            note: "I will join!"
          )
        end
      end
      
      # users is in other groups
      3.times do 
        password = Faker::Internet.password(8)
        user = User.create(
            name: Faker::Name.last_name,
            email: Faker::Internet.free_email,
            password: password,
            password_confirmation: password 
        )
        3.times do
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
            note: "Please gather on time!"
          )
          reservation = Reservation.create(
            space_id: space.id,
            member_id: member.id,
            start_at: DateTime.now,
            end_at: DateTime.now + 1.hour,
            note: "I will join!"
          )
        end
      end
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
        note: "Please gather on time!"
      )
      reservation = Reservation.create(
        space_id: space.id,
        member_id: member.id,
        start_at: DateTime.now,
        end_at: DateTime.now + 1.hour,
        note: "I will join!"
      )
      
      # users is in the same group as login_user
      3.times do 
        password = Faker::Internet.password(8)
        user = User.create(
            name: Faker::Name.last_name,
            email: Faker::Internet.free_email,
            password: password,
            password_confirmation: password 
        )
        3.times do
          member = Member.create(
            user_id: user.id,
            group_id: group.id,
          )
          space = Space.create(
            group_id: group.id,
            start_at: DateTime.now,
            end_at: DateTime.now + 1.hour,
            note: "Please gather on time!"
          )
          reservation = Reservation.create(
            space_id: space.id,
            member_id: member.id,
            start_at: DateTime.now,
            end_at: DateTime.now + 1.hour,
            note: "I will join!"
          )
        end
      end
      
      # users is in other groups
      3.times do 
        password = Faker::Internet.password(8)
        user = User.create(
            name: Faker::Name.last_name,
            email: Faker::Internet.free_email,
            password: password,
            password_confirmation: password 
        )
        3.times do
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
            note: "Please gather on time!"
          )
          reservation = Reservation.create(
            space_id: space.id,
            member_id: member.id,
            start_at: DateTime.now,
            end_at: DateTime.now + 1.hour,
            note: "I will join!"
          )
        end
      end
    end
  end
end
