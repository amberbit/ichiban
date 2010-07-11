# encoding: utf-8

require 'spec_helper'

describe User do

  it "should be created when valid attributes passed" do
    u = User.new valid_user_attributes

    u.save.should be_true
  end

  it "should require name" do
    u = User.new valid_user_attributes.select {|k| k!=:name}
    u.save.should be_false
  end

  it "should require unique email" do
    u = User.new valid_user_attributes.select {|k| k!=:email}
    u.save.should be_false
  end
  
  it "should require user image" do
    u = User.new valid_user_attributes.select {|k| k!=:picture }
    u.save.should be_false
  end

  it "should not be admin by default" do
    u = User.create valid_user_attributes
    u.should_not be_admin
  end

  it "should not become admin with multi-assignment" do
    u = User.create valid_user_attributes.merge(admin: true)
    u.should_not be_admin
  end

  it "should be possible to make user admin directly" do
    u = User.new valid_user_attributes
    u.admin = true
    u.save.should be_true
  end
end
