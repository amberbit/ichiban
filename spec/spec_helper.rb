# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"
require "rspec/rails"

Rails.backtrace_cleaner.remove_silencers!

# Configure capybara for integration testing
require "capybara/rails"
Capybara.default_driver   = :rack_test
Capybara.default_selector = :css

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

Rspec.configure do |config|
  # Remove this line if you don't want Rspec's should and should_not
  # methods or matchers
  require 'rspec/expectations'
  config.include Rspec::Matchers

  config.before(:each) do
    Mongoid.database.collections.each {|col| begin col.drop; rescue; end }
  end


  # == Mock Framework
  config.mock_with :rspec
end

def valid_user_attributes(custom_attributes={})
  { name: "John Doe", email: "john@doe.com", password: "asdf1234",
    picture: File.open(File.join(File.dirname(__FILE__), "..", "spec", "fixtures", "picture.jpg"), "r")}.merge(custom_attributes)
end

def valid_article_attributes
  {user: User.first, title: "Some article", body: "Some body", slug: "some-article"}
end

def valid_snippet_attributes
  {name: "hello", content: "# World!"}
end

def valid_asset_attributes
  {title: "Some asset", file: File.new(File.join(File.dirname(__FILE__), "..", "spec", "fixtures", "picture.jpg"), "r")}
end

def valid_path_attributes
  {request_path: "/something", priority: 1}
end

def valid_comment_attributes
  {email: "a@b.com", name: "John Doe", content: "How are you doing?", path: "/"}
end

