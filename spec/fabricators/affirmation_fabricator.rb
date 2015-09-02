Fabricator :affirmation do
  text { Faker::Lorem.sentence }
  user { Fabricate(:user) }
end