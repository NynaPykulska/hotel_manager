class Issue < ApplicationRecord
	validates_presence_of :room_id
	belongs_to :author
	has_one :issue_type
end
