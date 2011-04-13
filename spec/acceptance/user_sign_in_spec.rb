# encoding: utf-8

require File.dirname(__FILE__) + '/acceptance_helper'

  feature "User sign in", %q{
    In order to use the admin panel
    As a user
    I want to sign in
  } do
  
  scenario "Accessing admin panel" do
    when_i_sign_in_as "john@doe.com"
    current_path.should eql("/admin")
  end

  scenario "Signing out" do
    when_i_sign_in_as("john@doe.com")
    click_link "Sign out"
    visit "/admin"
    current_path.should eql("/users/sign_in")
  end
end
