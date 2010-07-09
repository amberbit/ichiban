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
    a = Asset.create
    a.destroy
    Asset.count.should eql(0)
  end

  it "should not be possible to remove asset used in article"

  it "should not be possible to remove asset used in snippet"

end