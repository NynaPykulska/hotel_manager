class Memo < ApplicationRecord
	validates_presence_of :description
	belongs_to :room
end
