require "test_helper"

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
class PersonTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
