# Model class for users. One users of the
# application is represented by exacly one
# record in the databse. Devise gem is used to
# manage users. Users can have roles and can
# use nick/email to log in.
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  enum role: %i[admin receptionist maid maitenance]

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :maid
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
