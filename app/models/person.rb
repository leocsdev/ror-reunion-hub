# == Schema Information
#
# Table name: people
#
#  id          :bigint           not null, primary key
#  email       :string
#  first_name  :string           not null
#  last_name   :string           not null
#  maiden_name :string
#  mobile      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Person < ApplicationRecord
  has_many :reunion_memberships, dependent: :destroy
  has_many :reunions, through: :reunion_memberships

  normalizes :email, with: ->(email) { email.to_s.strip.downcase.presence }

  validates :first_name, :last_name, presence: true
end
