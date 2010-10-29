# encoding: utf-8

require 'spec_helper'

describe Comment do

  before(:each) do
    @user = User.create! valid_user_attributes
    @user2 = User.create! valid_user_attributes(receive_comment_notification: true, email: "a@b.com")
    @user3 = User.create! valid_user_attributes(receive_comment_notification: true, email: "c@d.com")
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
  end

  it "should be possible to create comment for a path" do
    Comment.create! valid_comment_attributes
  end

  it "should notify proper users when comment added" do
    Comment.create! valid_comment_attributes
    ActionMailer::Base.deliveries.size.should eql(1)
    ActionMailer::Base.deliveries.first.to_addrs.size.should eql(2)
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
