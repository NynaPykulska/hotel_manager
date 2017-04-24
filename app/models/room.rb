class Room < ApplicationRecord
	validates_presence_of :room_id
	has_many :issues, dependent: :destroy
	has_many :memos, dependent: :destroy
	attr_accessor :selectedIssues	
end
