require 'test_helper'

class MembersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'Member.count' , 1 do
      post members_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    follow_redirect!
    assert_template 'members/new'
    assert_not flash.FILL_IN
  end
end

