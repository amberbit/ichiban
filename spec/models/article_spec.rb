require 'spec_helper'

describe Article do

  before :each do
    @user = User.create! valid_user_attributes
  end

  it "should be possible to create with user, title, slug and body" do
    Article.create! valid_article_attributes
  end

  it "should be possible to assign extended body to article" do
    article = Article.create valid_article_attributes.merge(body_extended: "elo")
    article.body_extended.should eql("elo")
  end

  it "should require title" do
    Article.new(valid_article_attributes.select{|k| k!= :title}).should_not be_valid
  end

  it "should require slug" do
    Article.new(valid_article_attributes.select{|k| k!= :slug}).should_not be_valid
  end

  it "should require body" do
    Article.new(valid_article_attributes.select{|k| k!= :body}).should_not be_valid
  end

  it "should require user" do
    Article.new(valid_article_attributes.select{|k| k!= :user}).should_not be_valid
  end

  it "should be removed when user is being removed" do
    Article.create valid_article_attributes
    @user.destroy
    Article.count.should eql(0)
  end

  it "should have date" do
    Article.create(valid_article_attributes).created_at.should be_kind_of(Time)
  end
end
