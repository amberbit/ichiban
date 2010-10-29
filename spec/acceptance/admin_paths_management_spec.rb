# encoding: utf-8

require File.dirname(__FILE__) + '/acceptance_helper'

feature "Admin path management", %q{
    In order to have my site SEO friendly
    As a admin
    I want to have place to manage paths, keywords and titles
  } do

  scenario "Creating new path" do
    when_user_exists "john@doe.com", true
    when_i_sign_in_as "john@doe.com"
    visit "/admin"
    click_link I18n.t("admin.paths")
    click_link I18n.t("admin.path.new")
    fill_in I18n.t("activemodel.attributes.path.title"), with: "Our new blog!"
    fill_in I18n.t("activemodel.attributes.path.request_path"), with: "/our-new-blog"
    fill_in I18n.t("activemodel.attributes.path.keywords_string"), with: "some, random, keywords"
    select "10", from: I18n.t("activemodel.attributes.path.priority")
    click_button I18n.t("submit")
    Path.count.should eql(1)
  end

  scenario "Seeing a list of paths" do
    when_user_exists "john@doe.com", true
    when_i_sign_in_as "john@doe.com"
    when_path_exists "/some-path"
    when_path_exists "/some-other-path*"
    visit "/admin/paths"
    page.body.should include("/some-path")
    page.body.should include("/some-other-path")
  end

  scenario "Not being able to manage path as not administrator" do
    when_i_sign_in_as "john@doe.com"
    visit "/admin/paths"
    current_path.should eql("/admin")
  end

  scenario "Editing existing path" do
    when_user_exists "john@doe.com", true
    when_i_sign_in_as "john@doe.com"
    when_path_exists "/some-path"
    visit "/admin/paths/#{Path.first.id}"
    fill_in I18n.t("activemodel.attributes.path.title"), with: "Ah, snap!"
    click_button I18n.t("submit")
    Path.first(conditions: {title: "Ah, snap!"}).should_not be_nil
  end
  
  scenario "Removing existing path" do
    when_user_exists "john@doe.com", true
    when_i_sign_in_as "john@doe.com"
    when_path_exists "/some-path"
    visit "/admin/paths"
    click_link I18n.t("delete")
    Path.count.should eql(0)
  end
end
