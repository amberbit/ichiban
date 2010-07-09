require File.dirname(__FILE__) + '/acceptance_helper'

feature "Admin article management", %q{
    In order to have interesting content on my site
    As a user
    I want to have place to manage articles
  } do

  scenario "Creating new article" do
    when_i_sign_in_as "john@doe.com"
    visit "/admin"
    click_link I18n.t("admin.articles")
    click_link I18n.t("admin.article.new")
    fill_in I18n.t("activemodel.attributes.article.title"), with: "Our new blog!"
    fill_in I18n.t("activemodel.attributes.article.slug"), with: "our-new-blog"
    fill_in I18n.t("activemodel.attributes.article.body"), with: "Welcome! Our new blog is here!"
    fill_in I18n.t("activemodel.attributes.article.extended_body"), with: "Hey ho!"
    fill_in I18n.t("activemodel.attributes.article.keywords_string"), with: "some, random, keywords"
    click_button I18n.t("submit")
    Article.count.should eql(1)
  end

  scenario "Seeing a list of articles" do
    when_i_sign_in_as "john@doe.com"
    when_article_exists "Test article 1"
    when_article_exists "Test article 2"
    visit "/admin/articles"
    page.body.should include("Test article 1")
    page.body.should include("Test article 2")
  end

  scenario "Publishing article by administrator" do
    when_user_exists "john@doe.com", true
    when_i_sign_in_as "john@doe.com"
    when_article_exists "Test article 1"
    visit "/admin/articles"
    click_link I18n.t("admin.article.publish")
    Article.first.should be_published
  end
  
  scenario "Not being able to publish article as not administrator" do
    when_i_sign_in_as "john@doe.com"
    when_article_exists "Test article 1"
    visit "/admin/articles/#{Article.first.id}/publish"
    Article.first.should_not be_published
  end

  scenario "Not being able to edit/remove article as not administrator when it's already published" do
    when_i_sign_in_as "john@doe.com"
    when_article_exists "Test article 1"
    a = Article.first
    a.published = true
    a.save
    visit "/admin/articles/#{Article.first.id}/edit"
    current_path.should eql("/admin/articles/#{Article.first.id}")
  end

  scenario "Seeing article preview" do
    when_i_sign_in_as "john@doe.com"
    when_article_exists "Test article 1"
    visit "/admin/articles/#{Article.first.id}"
    page.body.should include("Test article 1")
    page.body.should include("<h1>Hello!</h1>")
    page.body.should include("<h2>World!</h2>")
  end

  scenario "Editing existing article" do
    when_user_exists "john@doe.com", true
    when_i_sign_in_as "john@doe.com"
    when_article_exists "Test article 1"
    visit "/admin/articles/#{Article.first.id}"
    click_link I18n.t("edit")
    fill_in I18n.t("activemodel.attributes.article.title"), with: "Ah, snap!"
    click_button I18n.t("submit")
    Article.first(conditions: {title: "Ah, snap!"}).should_not be_nil
  end
  
  scenario "Removing existing article" do
    when_user_exists "john@doe.com", true
    when_i_sign_in_as "john@doe.com"
    when_article_exists "Test article 1"
    visit "/admin/articles"
    click_link I18n.t("delete")
    Article.count.should eql(0)
  end
end
