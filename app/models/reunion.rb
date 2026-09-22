class Reunion < ApplicationRecord
  has_many :reunion_memberships, dependent: :destroy
  has_many :people, through: :reunion_memberships

  validates :name, :event_date, presence: true
end
