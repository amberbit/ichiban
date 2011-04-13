# encoding: utf-8

require 'spec_helper'

describe ContentProcessor do

  before :each do
    @asset = Asset.create! valid_asset_attributes
  end

  it "should expand image tag with asset number" do
    text = ContentProcessor.expand_image_tag "image_asset##{@asset.id}"
    text.should == "![Some asset](/uploads/asset/file/#{@asset.id}/picture.jpg \"Some asset\")"
  end
  
end