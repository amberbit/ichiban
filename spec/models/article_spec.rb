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

  it "should pre-process body with given processor"

  it "should pre-process extended body with given processor"

  it "should have date" do
    Article.create(valid_article_attributes).created_at.should be_kind_of(Time)
  end

  it "should not be published by default" do
    Article.create(valid_article_attributes).should_not be_published
  end

  it "should be possible to publish article" do
    a = Article.create(valid_article_attributes)
    a.published = true
    a.save
    a.should be_published
  end

  it "should not be possible to publish article with mass assignment" do
    a = Article.create(valid_article_attributes)
    a.update_attributes(published: true)
    a.should_not be_published
  end

  it "should create initial version of document when creating an article"
  
  it "should save versions of document on each change"

  it "should not change current version automatically"

  it "should not be possible to assign current version with mass-assignment"

  it "should be possible to change a published version when needed"

  it "should store current version attributes in article and change them when changing version"
  
end

describe Article, "content processing" do

  it "should convert Markdown to HTML for article body"

  it "should convert Markdown to HTML for article extended body"

  it "should recognize custom tag for embedding images"

  it "should recognize custom tag for embedding videos"

end
