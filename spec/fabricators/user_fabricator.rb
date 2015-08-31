Fabricator :user do
  name { Faker::Name.name }
  email { Faker::Internet.email }
  phone { Faker::PhoneNumber.phone_number }
  password { Faker::Internet.password }
end