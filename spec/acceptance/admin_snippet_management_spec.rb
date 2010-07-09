require File.dirname(__FILE__) + '/acceptance_helper'

feature "Admin snippet management", %q{
    In order to have dynamic content on my site
    As a administrator
    I want to have place to manage snippets
  } do

  scenario "Creating new snippet" do
    when_user_exists "john@doe.com", true
    when_i_sign_in_as "john@doe.com"
    visit "/admin"
    click_link I18n.t("admin.snippets")
    click_link I18n.t("admin.snippet.new")
    fill_in I18n.t("activemodel.attributes.snippet.name"), with: "hello"
    fill_in I18n.t("activemodel.attributes.snippet.content"), with: "# this is cool"
    click_button I18n.t("submit")
    Snippet.count.should eql(1)
  end

  scenario "Seeing a list of snippets" do
    when_user_exists "john@doe.com", true
    when_i_sign_in_as "john@doe.com"
    when_snippet_exists "hello"
    when_snippet_exists "world"
    visit "/admin/snippets"
    page.body.should include("hello")
    page.body.should include("world")
  end

  scenario "Seeing snippet preview" do
    when_user_exists "john@doe.com", true
    when_i_sign_in_as "john@doe.com"
    when_snippet_exists "hello", "# Hello, world!"
    visit "/admin/snippets/#{Snippet.first.id}"
    page.body.should include("<h1>Hello, world!</h1>")
  end

  scenario "Editing existing snippets" do
    when_user_exists "john@doe.com", true
    when_i_sign_in_as "john@doe.com"
    when_snippet_exists "hello", "# Hello, world!"
    visit "/admin/snippets/#{Snippet.first.id}"
    click_link I18n.t("edit")
    fill_in I18n.t("activemodel.attributes.snippet.content"), with: "## Ah, snap!"
    click_button I18n.t("submit")
    Snippet.first.content.should include("<h2>Ah, snap!</h2>")
  end
  
  scenario "Removing existing snippet" do
    when_user_exists "john@doe.com", true
    when_i_sign_in_as "john@doe.com"
    when_snippet_exists "hello"
    visit "/admin/snippets"
    click_link I18n.t("delete")
    Snippet.count.should eql(0)
  end

  scenario "Not being able to access snippets as not administrator" do
    when_user_exists "john@doe.com", true
    when_i_sign_in_as "john@doe.com"
    visit "/admin/snippets"
    current_path.should eql("/user/sign_in")
  end
end
