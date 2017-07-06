# Model class for rooms. One room is
# represented by one record in the
# database. Room can have Issues and
# Memos assigned to them (by room_id)
class Room < ApplicationRecord
  validates_presence_of :room_id
  has_many :issues, dependent: :destroy
  has_many :memos, dependent: :destroy
  attr_accessor :selected_issues
end
