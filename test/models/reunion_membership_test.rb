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
  test "validates uniqueness of person within a reunion" do
    membership = create(:reunion_membership)
    duplicate = build(:reunion_membership, person: membership.person, reunion: membership.reunion)

    assert_not duplicate.valid?
    assert_includes duplicate.errors[:person_id], "has already been taken"
  end

  test "database enforces uniqueness of person within a reunion even without validation" do
    membership = create(:reunion_membership)
    duplicate = build(:reunion_membership, person: membership.person, reunion: membership.reunion,
      rsvp_token_digest: ReunionMembership.digest_rsvp_token(SecureRandom.urlsafe_base64(32)))

    assert_raises(ActiveRecord::RecordNotUnique) do
      duplicate.save(validate: false)
    end
  end

  test "issues a plaintext token and matching digest on create" do
    membership = create(:reunion_membership)

    assert membership.rsvp_token.present?
    assert_equal ReunionMembership.digest_rsvp_token(membership.rsvp_token), membership.rsvp_token_digest
  end

  test "find_by_rsvp_token resolves a membership by its plaintext token" do
    membership = create(:reunion_membership)

    assert_equal membership, ReunionMembership.find_by_rsvp_token(membership.rsvp_token)
  end

  test "find_by_rsvp_token returns nil for blank or unknown tokens" do
    assert_nil ReunionMembership.find_by_rsvp_token(nil)
    assert_nil ReunionMembership.find_by_rsvp_token("")
    assert_nil ReunionMembership.find_by_rsvp_token("not-a-real-token")
  end

  test "regenerate_rsvp_token! rotates the digest and invalidates the old token" do
    membership = create(:reunion_membership)
    old_token = membership.rsvp_token
    old_digest = membership.rsvp_token_digest

    membership.regenerate_rsvp_token!

    assert_not_equal old_token, membership.rsvp_token
    assert_not_equal old_digest, membership.rsvp_token_digest
    assert_nil ReunionMembership.find_by_rsvp_token(old_token)
    assert_equal membership, ReunionMembership.find_by_rsvp_token(membership.rsvp_token)
  end
end
