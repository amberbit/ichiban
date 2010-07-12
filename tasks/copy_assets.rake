require 'fileutils'

namespace :ichiban do
  desc "Copy static assets ang Gemfile to main application"
  task :initialize do
    FileUtils.cp File.join(File.dirname(__FILE__), "..", "Gemfile"), Rails.root
    FileUtils.cp File.join(File.dirname(__FILE__), "..", "public", "images", "amberbit.png"), File.join(Rails.root, "public", "images")
    FileUtils.cp File.join(File.dirname(__FILE__), "..", "public", "stylesheets", "reset.css"), File.join(Rails.root, "public", "stylesheets")
    FileUtils.cp File.join(File.dirname(__FILE__), "..", "public", "stylesheets", "admin.css"), File.join(Rails.root, "public", "stylesheets")
    FileUtils.cp File.join(File.dirname(__FILE__), "..", "public", "javascripts", "rails.js"), File.join(Rails.root, "public", "javascripts")
    FileUtils.cp File.join(File.dirname(__FILE__), "..", "public", "javascripts", "ichiban.js"), File.join(Rails.root, "public", "javascripts")


  end
end
