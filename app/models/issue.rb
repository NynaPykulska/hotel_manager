# This is the model class for Issue,
# every created issue is represented
# by one record in the database
class Issue < ApplicationRecord
  # ID of the room that this Issue is assigned to
  validates_presence_of :room_id
  # one-to-many relationship with Room objects
  belongs_to :room
  # one-to many relationship with Issue_Types
  has_one :issue_type
  attr_accessor :start_date
  attr_accessor :end_date
  attr_accessor :recurrence
  attr_accessor :pattern
end
