require 'spec_helper'

describe Snippet do

  it "should be saved in database when valid attributes were passed" do
    Snippet.create! valid_snippet_attributes
  end

  it "should require name to be created" do
    Snippet.create(valid_snippet_attributes.select{|a| a!=:name}).should be_new_record
  end

  it "should require content to be created" do
    Snippet.create(valid_snippet_attributes.select{|a| a!=:content}).should be_new_record
  end

  it "should process content with markdown to html" do
    Snippet.create(valid_snippet_attributes).content_html.should include("<h1>World!</h1>")
  end

  it "shoul have unique name" do
    Snippet.create valid_snippet_attributes
    Snippet.create(valid_snippet_attributes).errors.on(:name).should_not be_nil
  end
end
