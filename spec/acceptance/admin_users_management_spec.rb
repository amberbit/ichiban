require File.dirname(__FILE__) + '/acceptance_helper'

feature "Admin users management", %q{
    In order to add or remove users
    As a administrator
    I want to have place to manage users
  } do
  
  scenario "Being blocked when not having enough rights to access it" do
    when_i_sign_in_as "john@doe.com"
    visit "/admin/users"
    current_path.should eql("/admin")
    page.body.should include(I18n.t("admin.admin_required"))
  end

  scenario "Being allowed to enter when user is admin" do
    when_user_exists "john@doe.com", true
    when_i_sign_in_as "john@doe.com"
    visit "/admin/users"
    current_path.should eql("/admin/users")
  end

  scenario "Seeing a list of users" do
    when_user_exists "jane@doe.com"
    when_user_exists "john@doe.com", true
    when_i_sign_in_as "john@doe.com"
    click_link I18n.t("admin.users")
    page.body.should include("john@doe.com")
    page.body.should include("jane@doe.com")
  end

  scenario "Creating a new user" do
    when_user_exists "john@doe.com", true
    when_i_sign_in_as "john@doe.com"
    visit "/admin"
    click_link I18n.t("admin.users")
    click_link I18n.t("admin.user.new")
    fill_in I18n.t("activemodel.attributes.user.name"), with: "John Smith"
    fill_in I18n.t("activemodel.attributes.user.email"), with: "john@smith.com"
    fill_in I18n.t("activemodel.attributes.user.password"), with: "testtest"
    attach_file I18n.t("activemodel.attributes.user.picture"), "#{Rails.root}/spec/fixtures/picture.jpg"
    click_button I18n.t("submit")
    User.find(:first, conditions: {email: "john@doe.com"}).should_not be_nil
  end

  scenario "Editing user details" do
    when_user_exists "john@doe.com", true
    when_i_sign_in_as "john@doe.com"
    visit "/admin"
    click_link I18n.t("admin.users")
    click_link I18n.t("edit")
    fill_in I18n.t("activemodel.attributes.user.email"), with: "john@smithhh.com"
    fill_in I18n.t("activemodel.attributes.user.password"), with: "testtest"
    click_button I18n.t("submit")
    User.find(:first, conditions: {email: "john@smithhh.com"}).should_not be_nil
  end

  scenario "Deleting user" do
    when_user_exists "a@b.com"
    when_user_exists "john@doe.com", true
    when_i_sign_in_as "john@doe.com"
    visit "/admin"
    click_link I18n.t("admin.users")
    click_link I18n.t('delete')
    User.count.should eql(1)
  end
end
