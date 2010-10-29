# encoding: utf-8

require 'spec_helper'

describe Asset do

  it "should be possible to create asset" do
    Asset.create! valid_asset_attributes
  end

  it "should require title" do
    Asset.create(valid_asset_attributes.select{|a| a!=:title}).should be_new_record
  end

  it "should require file" do
    Asset.create(valid_asset_attributes.select{|a| a!=:file}).should be_new_record
  end

  it "should be possible to remove asset not used in articles and snippets" do
    a = Asset.create valid_asset_attributes
    a.destroy
    Asset.count.should eql(0)
  end

  it "should not be possible to remove asset used in article as image" do
    User.create! valid_user_attributes
    a = Asset.create! valid_asset_attributes
    Article.create! valid_article_attributes.merge({body: "image_asset##{a.id}"})
    a.destroy
    Asset.count.should eql(1)
  end

  it "should not be possible to remove asset used in snippet as image" do
    User.create! valid_user_attributes
    s = Asset.create! valid_asset_attributes
    Snippet.create! valid_snippet_attributes.merge({content: "image_asset##{s.id}"})
    s.destroy
    Asset.count.should eql(1)
  end

end