# encoding: utf-8

require File.dirname(__FILE__) + '/acceptance_helper'

feature "Admin assets management", %q{
    In order to embed assets into articles/snippets
    As a user
    I want to have place to manage them
  } do

  scenario "Uploading a file" do
    when_i_sign_in_as "john@doe.com"
    visit "/admin"
    click_link I18n.t("admin.assets")
    click_link I18n.t("admin.asset.new")
    fill_in I18n.t("activemodel.attributes.asset.title"), with: "My face!"
    attach_file I18n.t("activemodel.attributes.asset.file"), "#{Rails.root}/../fixtures/picture.jpg"
    click_button I18n.t("submit")
    Asset.count.should eql(1)
  end

  scenario "Seeing a list of assets" do
    when_i_sign_in_as "john@doe.com"
    when_asset_exists "Test asset 1"
    when_asset_exists "Test asset 2"
    visit "/admin/assets"
    page.body.should include("Test asset 1")
    page.body.should include("Test asset 2")
  end

  scenario "Editing existing asset" do
    when_user_exists "john@doe.com", true
    when_i_sign_in_as "john@doe.com"
    when_asset_exists "Test asset 1"
    visit "/admin/assets/#{Asset.first.id}/edit"
    fill_in I18n.t("activemodel.attributes.asset.title"), with: "Ah, snap!"
    click_button I18n.t("submit")
    Asset.first(conditions: {title: "Ah, snap!"}).should_not be_nil
  end
  
  scenario "Removing existing assets" do
    when_user_exists "john@doe.com", true
    when_i_sign_in_as "john@doe.com"
    when_asset_exists "Test asset 1"
    visit "/admin/assets"
    click_link I18n.t("delete")
    Asset.count.should eql(0)
  end

  scenario "Not being able to remove asset that is being used by some articles or snippets"
end
