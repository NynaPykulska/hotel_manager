class Memo < ApplicationRecord
	validates_presence_of :description
	belongs_to :room
	attr_accessor :start_date
	attr_accessor :end_date
	attr_accessor :recurrence
	attr_accessor :pattern
end
