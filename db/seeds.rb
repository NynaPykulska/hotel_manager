# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



lamp = IssueType.create(	issue_type_id: 1,
				    issue_desctiption: "Broken lamp",
				    default_priority: "Medium",
				    when_to_resolve: "As soon as possible",
				    icon: File.new("/home/micc/Pulpit/hotel_manager/app/assets/images/Desk Lamp.png"))

light = IssueType.create(	issue_type_id: 2,
				    issue_desctiption: "No light",
				    default_priority: "High",
				    when_to_resolve: "As soon as possible",
				    icon: File.new("/home/micc/Pulpit/hotel_manager/app/assets/images/Light Off.png"))

water = IssueType.create(	issue_type_id: 3,
				    issue_desctiption: "No water",
				    default_priority: "High",
				    when_to_resolve: "As soon as possible",
				    icon: File.new("/home/micc/Pulpit/hotel_manager/app/assets/images/Water.png"))

paper = IssueType.create(	issue_type_id: 4,
				    issue_desctiption: "No toilet paper",
				    default_priority: "Medium",
				    when_to_resolve: "As soon as possible",
				    icon: File.new("/home/micc/Pulpit/hotel_manager/app/assets/images/Toilet Paper.png"))


10.times do |i|
	fuckingroom = Room.create(room_id: i+100, description: "ROOM DESCRIPTION", is_clean: false)

	case (i%3)
	when 0
	  fuckingroom.issues.create(
        			issue_type_id: lamp.issue_type_id,
        			requested_fix_date: DateTime.new(2020,01,10),
        			fix_comment: "No comments on this one",
        			timestamp: Date.today,
        			priority: "High")
	when 1
	  fuckingroom.issues.create(
        			issue_type_id: light.issue_type_id,
        			requested_fix_date: DateTime.new(2020,01,10),
        			fix_comment: "No comments on this one",
        			timestamp: Date.today,
        			priority: "Medium")
	  fuckingroom.issues.create(
        			issue_type_id: water.issue_type_id,
        			requested_fix_date: DateTime.new(2020,01,10),
        			fix_comment: "No comments on this one",
        			timestamp: Date.today,
        			priority: "Low")
	when 2
	  fuckingroom.issues.create(
        			issue_type_id: lamp.issue_type_id,
        			requested_fix_date: DateTime.new(2020,01,10),
        			fix_comment: "No comments on this one",
        			timestamp: Date.today,
        			priority: "High")
	  fuckingroom.issues.create(
        			issue_type_id: light.issue_type_id,
        			requested_fix_date: DateTime.new(2020,01,10),
        			fix_comment: "No comments on this one",
        			timestamp: Date.today,
        			priority: "Medium")
	  fuckingroom.issues.create(
        			issue_type_id: paper.issue_type_id,
        			requested_fix_date: DateTime.new(2020,01,10),
        			fix_comment: "No comments on this one",
        			timestamp: Date.today,
        			priority: "Low")
	end

end



10.times do |i|
	fuckingroom = Room.create(room_id: i+300, description: "ROOM DESCRIPTION", is_clean: true)
 	fuckingroom.memos.create(room_id: i+300, description: "MEMO DESCRIPTION", deadline: DateTime.new(2017,01,10), completion_date: DateTime.new(2016,12,30), is_done: true, time_stamp: DateTime.new(2016,12,11) )
end

10.times do |i|
	fuckingroom = Room.create(room_id: i+500, description: "ROOM DESCRIPTION", is_clean: false)
 	fuckingroom.memos.create(room_id: i+500, description: "MEMO DESCRIPTION", deadline: DateTime.new(2017,10,10), is_done: false, time_stamp: DateTime.new(2016,12,11) )
end

User.create(username: 'nina', email: 'nina@nina.com', password: 'buttsex', password_confirmation: 'buttsex')