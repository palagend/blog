require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test 'test layout links' do
    get root_path
    assert_template 'static_pages/home'
    assert_select  "a:match('href',?)", help_path
    assert_select  "a:match('href',?)", about_path
    assert_select  "a:match('href',?)", contact_path
    get contact_path
    assert_select "title", full_title("Contact")
  end
end
