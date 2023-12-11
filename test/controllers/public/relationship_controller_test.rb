require "test_helper"

class Public::RelationshipControllerTest < ActionDispatch::IntegrationTest
  test "should get follower" do
    get public_relationship_follower_url
    assert_response :success
  end

  test "should get followed" do
    get public_relationship_followed_url
    assert_response :success
  end
end
