# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |i|
	Room.create(number: i+300, description: "ROOM DESCRIPTION")
 	Memo.create(room_no: i+300, description: "MEMO DESCRIPTION", deadline: DateTime.new(2017,01,10), completion_date: DateTime.new(2016,12,30), is_done: true, time_stamp: DateTime.new(2016,12,11) )
end

10.times do |i|
 	Memo.create(room_no: i+300, description: "MEMO DESCRIPTION", deadline: DateTime.new(2017,01,10), is_done: false, time_stamp: DateTime.new(2016,10,11))
end