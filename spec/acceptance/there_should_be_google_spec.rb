require File.dirname(__FILE__) + '/acceptance_helper'

feature "Feature name", %q{
  In order to use the internet
  As a  user
  I want to use google
} do
  
  scenario "Verifying there is google" do
    visit "http://google.com"
    page.should have_css("input[name='q']")
  end
  
end
