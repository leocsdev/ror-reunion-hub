require "test_helper"

# == Schema Information
#
# Table name: reunion_memberships
#
#  id                :bigint           not null, primary key
#  rsvp_token_digest :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  person_id         :bigint           not null
#  reunion_id        :bigint           not null
#
# Indexes
#
#  index_reunion_memberships_on_person_id                 (person_id)
#  index_reunion_memberships_on_person_id_and_reunion_id  (person_id,reunion_id) UNIQUE
#  index_reunion_memberships_on_reunion_id                (reunion_id)
#  index_reunion_memberships_on_rsvp_token_digest         (rsvp_token_digest) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (person_id => people.id)
#  fk_rails_...  (reunion_id => reunions.id)
#
class ReunionMembershipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
