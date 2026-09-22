class Person < ApplicationRecord
  has_many :reunion_memberships, dependent: :destroy
  has_many :reunions, through: :reunion_memberships

  normalizes :email, with: ->(email) { email.to_s.strip.downcase.presence }

  validates :first_name, :last_name, presence: true
end
