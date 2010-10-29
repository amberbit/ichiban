# encoding: utf-8

require 'spec_helper'

describe Comment do

  before(:each) { @user = User.create! valid_user_attributes }

  it "should be possible to create comment for a path" do
    Comment.create! valid_comment_attributes
  end

  it "should require email" do
    Comment.create(valid_comment_attributes.select{|a| a!=:email}).should be_new_record
  end

  it "should require name" do
    Comment.create(valid_comment_attributes.select{|a| a!=:name}).should be_new_record
  end

  it "should require content" do
    Comment.create(valid_comment_attributes.select{|a| a!=:content}).should be_new_record
  end

  it "should require path" do
    Comment.create(valid_comment_attributes.select{|a| a!=:path}).should be_new_record
  end
end