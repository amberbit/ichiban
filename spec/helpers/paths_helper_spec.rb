# encoding: utf-8

require 'spec_helper'

describe PathsHelper do
  include PathsHelper
  before :each do
    @path1 = Path.create!( request_path: "/admin/places",
                          title: "places module",
                          keywords_string: "admin, places", priority: 4 )
    @path2 = Path.create!( request_path: "/admin/*",
                          title: "the rest of admin panel",
                          keywords_string: "admin", priority: 1 )
    @path3 = Path.create!( request_path: "/adm*",
                          title: "the rest of admin panel",
                          keywords_string: "admin", priority: 2 )
    @path4 = Path.create!( request_path: "/public*",
                          title: "the rest of site",
                          keywords_string: "anything" )

  end

  it "should recognize given path" do
    recognize_path("/admin/places").should eql(@path1)
  end

  it "should recognize given path by priority" do
    recognize_path("/admin/sdfsdfsdf").should eql(@path3)
  end

  it "should get extra keywords for recognized path" do
    keywords_for_path("/admin/sdfsdfsdf").should eql(["admin"])
  end

  it "should return no extra keywords for unrecognized path" do
    keywords_for_path("/sdfsdf/sdfsdfsdf").should be_empty
  end

  it "should get title for recognized path" do
    title_for_path("/admin/sdfsdfsdf").should eql("the rest of admin panel")
  end

  it "should return no title for unrecognized path" do
    title_for_path("/ffffffff").should be_nil
  end
end