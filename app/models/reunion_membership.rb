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
class ReunionMembership < ApplicationRecord
  belongs_to :person
  belongs_to :reunion

  validates :person_id, uniqueness: { scope: :reunion_id }

  attr_reader :rsvp_token

  before_validation :issue_rsvp_token, on: :create

  def self.find_by_rsvp_token(token)
    return if token.blank?

    find_by(rsvp_token_digest: digest_rsvp_token(token))
  end

  def regenerate_rsvp_token!
    token = SecureRandom.urlsafe_base64(32)

    update!(rsvp_token_digest: self.class.digest_rsvp_token(token))
    @rsvp_token = token
  rescue ActiveRecord::RecordNotUnique
    retry
  end

  def self.digest_rsvp_token(token)
    Digest::SHA256.hexdigest(token)
  end

  private

  def issue_rsvp_token
    return if rsvp_token_digest.present?

    @rsvp_token = SecureRandom.urlsafe_base64(32)
    self.rsvp_token_digest = self.class.digest_rsvp_token(rsvp_token)
  end
end
