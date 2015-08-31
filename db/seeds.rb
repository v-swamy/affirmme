# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

vik = User.new(name: "Vikram Swamy", email: "vswamy@gmail.com", password: "password", phone: "4407258800")

Affirmation.create(text: "I am getting better every day.", user: vik)
Affirmation.create(text: "I am healthy and strong.", user: vik)
Affirmation.create(text: "I am calm in the face of conflict.", user: vik)
Affirmation.create(text: "I spend my money wisely.", user: vik)