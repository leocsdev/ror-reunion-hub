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
  test "requires a first name" do
    person = build(:person, first_name: nil)

    assert_not person.valid?
    assert_includes person.errors[:first_name], "can't be blank"
  end

  test "requires a last name" do
    person = build(:person, last_name: nil)

    assert_not person.valid?
    assert_includes person.errors[:last_name], "can't be blank"
  end

  test "normalizes email by stripping whitespace and downcasing" do
    person = create(:person, email: "  Alum@Example.com  ")

    assert_equal "alum@example.com", person.email
  end

  test "blank email normalizes to nil" do
    person = create(:person, email: "   ")

    assert_nil person.email
  end
end
