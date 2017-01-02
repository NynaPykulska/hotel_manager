class Room < ApplicationRecord
	validates_presence_of :room_no
	has_many :issues, dependent: :destroy
end
