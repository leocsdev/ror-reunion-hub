# == Schema Information
#
# Table name: reunions
#
#  id         :bigint           not null, primary key
#  event_date :date             not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Reunion < ApplicationRecord
  has_many :reunion_memberships, dependent: :destroy
  has_many :people, through: :reunion_memberships

  validates :name, :event_date, presence: true
end
