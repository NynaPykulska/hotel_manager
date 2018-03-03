# Model class fro issuetypes,
# one issue type is represented by one
# record in the database. Each Issue has exactly
# one datatype. IssueTypes are not aware of Issues
# that address them.
class IssueType < ApplicationRecord
  has_many :issue
end
