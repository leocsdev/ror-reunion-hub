require "application_system_test_case"

class RsvpAccessTest < ApplicationSystemTestCase
  test "alumnus visits their RSVP page with a valid token" do
    membership = create(:reunion_membership)

    visit rsvp_access_path(reunion_id: membership.reunion_id, token: membership.rsvp_token)

    assert_text "Welcome, #{membership.person.first_name}"
    assert_text membership.reunion.name
  end
end
