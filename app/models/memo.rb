class Memo < ApplicationRecord
	validates_presence_of :description
	belongs_to :room
	attr_accessor :date_of_tour
end
