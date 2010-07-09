# encoding: utf-8

# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# Hack around bug in Rspec when not using AR
module RSpec
  module Rails
    module TransactionalDatabaseSupport
      def active_record_configured?
        false
      end
    end
  end
end

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}


RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  config.before(:each) do
    Mongoid.database.collections.each {|col| begin col.drop; rescue; end }
  end

  #config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, comment the following line or assign false
  # instead of true.
  #config.use_transactional_fixtures = true
end


def valid_user_attributes
  { name: "John Doe", email: "john@doe.com", password: "asdf1234",
    picture: File.open("#{Rails.root}/spec/fixtures/picture.jpg", "r")}
end

def valid_article_attributes
  {user: User.first, title: "Some article", body: "Some body", slug: "some-article"}
end

def valid_snippet_attributes
  {name: "hello", content: "# World!"}
end

def valid_asset_attributes
  {title: "Some asset", file: File.new("#{Rails.root}/spec/fixtures/picture.jpg")}
end
