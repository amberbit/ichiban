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

end
