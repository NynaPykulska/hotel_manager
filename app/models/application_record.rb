# Base class for all models to inherit from
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
