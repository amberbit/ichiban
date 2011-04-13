# encoding: utf-8

require File.dirname(__FILE__) + '/acceptance_helper'

feature "Sending comments", %q{
    In order to leave his comment on a site
    As a user
    I want to be able to send a comment
  } do
  
  scenario "Sending a comment" do
    when_i_sign_in_as "john@doe.com"
    when_article_exists "Test article 1"
    visit "/articles/#{Article.first.id}"
    fill_in I18n.t("activemodel.attributes.comment.name"), with: "John Doe"
    fill_in I18n.t("activemodel.attributes.comment.email"), with: "a@b.com"
    fill_in I18n.t("activemodel.attributes.comment.content"), with: "This is great"
    click_button I18n.t("send")
    Comment.count.should eql(1)
  end

  scenario "Reloading a list of comments" do
    when_i_sign_in_as "john@doe.com"
    when_article_exists "Test article 1"
    visit "/articles/#{Article.first.id}"
    fill_in I18n.t("activemodel.attributes.comment.name"), with: "John Doe"
    fill_in I18n.t("activemodel.attributes.comment.email"), with: "a@b.com"
    fill_in I18n.t("activemodel.attributes.comment.content"), with: "This is great"
    click_button I18n.t("send")
    page.should have_content("This is great")
  end
end
