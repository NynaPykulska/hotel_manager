class Issue < ApplicationRecord
	validates_presence_of :room_id
	belongs_to :room
	has_one :issue_type
end
