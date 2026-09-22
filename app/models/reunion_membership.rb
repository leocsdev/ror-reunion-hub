class ReunionMembership < ApplicationRecord
  belongs_to :person
  belongs_to :reunion
end
