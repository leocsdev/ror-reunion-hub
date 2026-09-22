require "test_helper"

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
class ReunionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
