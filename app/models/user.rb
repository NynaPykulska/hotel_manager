class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:admin, :receptionist, :maid, :maitenance]

  after_initialize :set_default_role, :if => :new_record?

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
