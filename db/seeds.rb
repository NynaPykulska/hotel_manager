# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |i|
	Room.create(number: i+300, description: "ROOM DESCRIPTION")
 	Memo.create(room_no: i+300, description: "MEMO DESCRIPTION", completion_date: DateTime.new(2009,9,1,19))
end