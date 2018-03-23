require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title,         "Palagend Sample App"
    assert_equal full_title("Help"), "Help | Palagend Sample App"
  end
end
