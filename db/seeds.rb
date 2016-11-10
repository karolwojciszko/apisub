# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user1 = User.create([{ username: 'karolwojciszko', password: '098f6bcd4621d373cade4e832627b4f6' }])
#errorUnexpected = ErrorApi.create([{ number: 0, status: 500, message: 'Unexpected error' }])