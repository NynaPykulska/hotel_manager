# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


if ENV["old_seeds"]
	lamp = IssueType.create(	id: 1,
					    issue_description: "Broken lamp",
					    default_priority: "Medium",
					    when_to_resolve: "As soon as possible",
					    ok_icon: File.new("/home/micc/Pulpit/hotel_manager/app/assets/images/issue-icons/desklamp-ok.png"),
							nok_icon: File.new("/home/micc/Pulpit/hotel_manager/app/assets/images/issue-icons/desklamp-nok.png"))
				

	light = IssueType.create(	id: 2,
					    issue_description: "No light",
					    default_priority: "High",
					    when_to_resolve: "As soon as possible",
					    ok_icon: File.new("/home/micc/Pulpit/hotel_manager/app/assets/images/issue-icons/lightbulb-ok.png"),
							nok_icon: File.new("/home/micc/Pulpit/hotel_manager/app/assets/images/issue-icons/lightbulb-nok.png"))

	water = IssueType.create(	id: 3,
					    issue_description: "No water",
					    default_priority: "High",
					    when_to_resolve: "As soon as possible",
					    ok_icon: File.new("/home/micc/Pulpit/hotel_manager/app/assets/images/issue-icons/water-ok.png"),
							nok_icon: File.new("/home/micc/Pulpit/hotel_manager/app/assets/images/issue-icons/water-nok.png"))

	paper = IssueType.create(	id: 4,
					    issue_description: "No toilet paper",
					    default_priority: "Medium",
					    when_to_resolve: "As soon as possible",
					    ok_icon: File.new("/home/micc/Pulpit/hotel_manager/app/assets/images/issue-icons/toiletpaper-ok.png"),
							nok_icon: File.new("/home/micc/Pulpit/hotel_manager/app/assets/images/issue-icons/toiletpaper-nok.png"))


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

end

if ENV["new_seeds"]

	10.times do |i|
		Issue.create(
			room_id: 100+i,
			issue_type_id: 1,
			priority: "low",
			is_done: false,
			is_recurring: false
			)
		Issue.create(
			room_id: 100+i,
			issue_type_id: 2,
			priority: "low",
			is_done: false,
			is_recurring: false
			)
		Issue.create(
			room_id: 100+i,
			issue_type_id: 3,
			priority: "low",
			is_done: false,
			is_recurring: false
			)
		Issue.create(
			room_id: 100+i,
			issue_type_id: 4,
			priority: "low",
			is_done: false,
			is_recurring: false
			)

		Issue.create(
			room_id: 300+i,
			issue_type_id: 1,
			priority: "low",
			is_done: false,
			is_recurring: false
			)
		Issue.create(
			room_id: 300+i,
			issue_type_id: 2,
			priority: "low",
			is_done: false,
			is_recurring: false
			)
		Issue.create(
			room_id: 300+i,
			issue_type_id: 3,
			priority: "low",
			is_done: false,
			is_recurring: false
			)
		Issue.create(
			room_id: 300+i,
			issue_type_id: 4,
			priority: "low",
			is_done: false,
			is_recurring: false
			)

		Issue.create(
			room_id: 500+i,
			issue_type_id: 1,
			priority: "low",
			is_done: false,
			is_recurring: false
			)
		Issue.create(
			room_id: 500+i,
			issue_type_id: 2,
			priority: "low",
			is_done: false,
			is_recurring: false
			)
		Issue.create(
			room_id: 500+i,
			issue_type_id: 3,
			priority: "low",
			is_done: false,
			is_recurring: false
			)
		Issue.create(
			room_id: 500+i,
			issue_type_id: 4,
			priority: "low",
			is_done: false,
			is_recurring: false
			)
	end


end

if ENV["actual_hotel_stuff"]
	Room.create(room_id: 100, description: "Pokój wewnetrzny", is_clean: true)

	Room.create(room_id: 101, description: "Pokój dwuosobowy", is_clean: true)
	Room.create(room_id: 102, description: "Pokój dwuosobowy", is_clean: true)
	Room.create(room_id: 103, description: "Pokój dwuosobowy", is_clean: true)
	Room.create(room_id: 104, description: "Pokój dwuosobowy", is_clean: true)
	Room.create(room_id: 105, description: "Pokój dwuosobowy", is_clean: true)
	Room.create(room_id: 106, description: "Pokój dwuosobowy", is_clean: true)
	Room.create(room_id: 201, description: "Pokój dwuosobowy", is_clean: true)
	Room.create(room_id: 202, description: "Pokój dwuosobowy", is_clean: true)
	Room.create(room_id: 203, description: "Pokój dwuosobowy", is_clean: true)
	Room.create(room_id: 204, description: "Pokój dwuosobowy", is_clean: true)
	Room.create(room_id: 205, description: "Pokój dwuosobowy", is_clean: true)
	Room.create(room_id: 206, description: "Pokój dwuosobowy", is_clean: true)
	Room.create(room_id: 301, description: "Pokój dwuosobowy", is_clean: true)
	Room.create(room_id: 302, description: "Pokój dwuosobowy", is_clean: true)
	Room.create(room_id: 303, description: "Pokój dwuosobowy", is_clean: true)
	Room.create(room_id: 304, description: "Pokój dwuosobowy", is_clean: true)
	Room.create(room_id: 305, description: "Pokój dwuosobowy", is_clean: true)
	Room.create(room_id: 306, description: "Pokój dwuosobowy", is_clean: true)

	Room.create(room_id: 107, description: "Apartament", is_clean: true)
	Room.create(room_id: 207, description: "Apartament", is_clean: true)
	Room.create(room_id: 307, description: "Apartament", is_clean: true)

	Room.create(room_id: 108, description: "Pokój trzyosobowy", is_clean: true)
	Room.create(room_id: 208, description: "Pokój trzyosobowy", is_clean: true)
	Room.create(room_id: 308, description: "Pokój trzyosobowy", is_clean: true)

	Room.create(room_id: 1, description: "Anex", is_clean: true)
	Room.create(room_id: 2, description: "Anex", is_clean: true)
	Room.create(room_id: 3, description: "Anex", is_clean: true)
	Room.create(room_id: 4, description: "Anex", is_clean: true)
	Room.create(room_id: 5, description: "Anex", is_clean: true)
	Room.create(room_id: 6, description: "Anex", is_clean: true)
	Room.create(room_id: 7, description: "Anex", is_clean: true)
	Room.create(room_id: 8, description: "Anex", is_clean: true)
	Room.create(room_id: 9, description: "Anex", is_clean: true)
	Room.create(room_id: 10, description: "Anex", is_clean: true)

end

if ENV["issueTypes"]


	# water = File.new("C:/Users/ninap/Documents/workspace/hotel_manager/app/assets/images/issue-icons/water-ok.png")
	# airconditioner = File.new("C:/Users/ninap/Documents/workspace/hotel_manager/app/assets/images/issue-icons/airconditioner-ok.png")
	# lightbulb = File.new("C:/Users/ninap/Documents/workspace/hotel_manager/app/assets/images/issue-icons/lightbulb-ok.png")

	water = File.join(Rails.root, 'app', 'assets', 'images', 'issue-icons', 'water-ok.png')

	# airconditioner = File.new("C:/Users/ninap/Documents/workspace/hotel_manager/app/assets/images/issue-icons/airconditioner-ok.png")
	# lightbulb = File.new("C:/Users/ninap/Documents/workspace/hotel_manager/app/assets/images/issue-icons/lightbulb-ok.png")

	IssueType.create!(id: 1,
			    issue_description: "Popsuty kran",
			    default_priority: "Medium",
			    when_to_resolve: "As soon as possible",
			    ok_icon: File.read(water))
	IssueType.create!(id: 2,
			    issue_description: "Popsuty prysznic",
			    default_priority: "Medium",
			    when_to_resolve: "As soon as possible",
			    ok_icon: File.read(water))
	IssueType.create!(id: 3,
			    issue_description: "Zimny kaloryfer",
			    default_priority: "Medium",
			    when_to_resolve: "As soon as possible",
			    ok_icon: File.read(water))
	IssueType.create!(id: 4,
			    issue_description: "Brudna zasłonka prysznica",
			    default_priority: "Medium",
			    when_to_resolve: "As soon as possible",
			    ok_icon: File.read(water))
	IssueType.create!(id: 5,
			    issue_description: "Firanka do wymiany",
			    default_priority: "Medium",
			    when_to_resolve: "As soon as possible",
			    ok_icon: File.read(water))
	IssueType.create!(id: 6,
			    issue_description: "Lampka nocna lewa",
			    default_priority: "Medium",
			    when_to_resolve: "As soon as possible",
			    ok_icon: File.read(water))
	IssueType.create!(id: 7,
			    issue_description: "Lampka nocna prawa",
			    default_priority: "Medium",
			    when_to_resolve: "As soon as possible",
			    ok_icon: File.read(water))
	IssueType.create!(id: 8,
			    issue_description: "Lampka na biurku",
			    default_priority: "Medium",
			    when_to_resolve: "As soon as possible",
			    ok_icon: File.read(water))
	IssueType.create!(id: 9,
			    issue_description: "Wyrwany kontakt",
			    default_priority: "Medium",
			    when_to_resolve: "As soon as possible",
			    ok_icon: File.read(water))
	IssueType.create!(id: 10,
			    issue_description: "Popsuty telewizor",
			    default_priority: "Medium",
			    when_to_resolve: "As soon as possible",
			    ok_icon: File.read(water))
	IssueType.create!(id: 11,
			    issue_description: "Usterka szafy",
			    default_priority: "Medium",
			    when_to_resolve: "As soon as possible",
			    ok_icon: File.read(water))
	IssueType.create!(id: 12,
			    issue_description: "Brak wieszków",
			    default_priority: "Medium",
			    when_to_resolve: "As soon as possible",
			    ok_icon: File.read(water))
	IssueType.create!(id: 13,
			    issue_description: "Usterka sejfu",
			    default_priority: "Medium",
			    when_to_resolve: "As soon as possible",
			    ok_icon: File.read(water))
	IssueType.create!(id: 14,
			    issue_description: "Dywan",
			    default_priority: "Medium",
			    when_to_resolve: "As soon as possible",
			    ok_icon: File.read(water))
	IssueType.create!(id: 15,
			    issue_description: "Usterka toalety",
			    default_priority: "Medium",
			    when_to_resolve: "As soon as possible",
			    ok_icon: File.read(water))
	IssueType.create!(id: 16,
			    issue_description: "Popsuta spłuczka",
			    default_priority: "Medium",
			    when_to_resolve: "As soon as possible",
			    ok_icon: File.read(water))
	IssueType.create!(id: 17,
			    issue_description: "Zamek do ubikacji",
			    default_priority: "Medium",
			    when_to_resolve: "As soon as possible",
			    ok_icon: File.read(water))
end

if ENV["issues"]
	Room.all.each do |room|
		IssueType.all.each do |issueType|
			Issue.create(room_id: room.room_id,
			issue_type_id: issueType.id,
			priority: "Medium",
			is_done: true,
			is_recurring: false
			)
		end
	end

end