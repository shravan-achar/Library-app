require 'test_helper'

class HomepageControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get home_path
    assert_response :success
  end

  test "should get contact" do
    get homepage_contact_url
    assert_response :success
  end

  test "should get about" do
  	get homepage_about_url
  	assert_response :success
  end

end
