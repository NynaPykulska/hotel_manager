class Issue < ApplicationRecord
	validates_presence_of :room_id
	belongs_to :room
	has_one :issue_type
	attr_accessor :start_date
	attr_accessor :end_date
	attr_accessor :recurrence
	attr_accessor :pattern
end
