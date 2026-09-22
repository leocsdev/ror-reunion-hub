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
  test "requires a name" do
    reunion = build(:reunion, name: nil)

    assert_not reunion.valid?
    assert_includes reunion.errors[:name], "can't be blank"
  end

  test "requires an event date" do
    reunion = build(:reunion, event_date: nil)

    assert_not reunion.valid?
    assert_includes reunion.errors[:event_date], "can't be blank"
  end
end
