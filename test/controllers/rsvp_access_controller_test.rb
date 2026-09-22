require "test_helper"

class RsvpAccessControllerTest < ActionDispatch::IntegrationTest
  test "valid token for the matching reunion renders the RSVP page" do
    membership = create(:reunion_membership)

    get rsvp_access_path(reunion_id: membership.reunion_id, token: membership.rsvp_token)

    assert_response :success
    assert_includes @response.body, membership.person.first_name
    assert_includes @response.body, membership.reunion.name
  end

  test "valid token against a different reunion is not found" do
    membership = create(:reunion_membership)
    other_reunion = create(:reunion)

    get rsvp_access_path(reunion_id: other_reunion.id, token: membership.rsvp_token)

    assert_response :not_found
  end

  test "unknown token is not found" do
    reunion = create(:reunion)

    get rsvp_access_path(reunion_id: reunion.id, token: "not-a-real-token")

    assert_response :not_found
  end

  test "blank token is not found" do
    reunion = create(:reunion)

    get rsvp_access_path(reunion_id: reunion.id, token: " ")

    assert_response :not_found
  end

  test "one alumnus's token cannot be used to view another alumnus's reunion membership" do
    membership_a = create(:reunion_membership)
    membership_b = create(:reunion_membership)

    get rsvp_access_path(reunion_id: membership_b.reunion_id, token: membership_a.rsvp_token)

    assert_response :not_found
  end
end
