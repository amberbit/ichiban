# encoding: utf-8

require 'spec_helper'

describe Path do
  it "should be created when valid attributes" do
    Path.create! valid_path_attributes
  end

  it "should have unique name" do
    Path.create valid_path_attributes
    Path.create(valid_path_attributes).should be_new_record
  end

  it "should be possible to assign keywords" do
    Path.create(valid_path_attributes.merge(keywords_string: "uno, duo")).keywords.should_not be_empty
  end

  it "should be possible to assign description" do
    Path.create!(valid_path_attributes.merge(description: "uno, duo"))
  end

end
