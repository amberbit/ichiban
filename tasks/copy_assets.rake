require 'fileutils'

namespace :ichiban do
  desc "Copy static assets ang Gemfile to main application"
  task :initialize do
    FileUtils.cp File.join(File.dirname(__FILE__), "..", "Gemfile"), "."
    FileUtils.cp File.join(File.dirname(__FILE__), "..", "public", "images", "amberbit.png"), File.join(".", "public", "images")
    FileUtils.cp File.join(File.dirname(__FILE__), "..", "public", "stylesheets", "reset.css"), File.join(".", "public", "stylesheets", "reset.css")
    FileUtils.cp File.join(File.dirname(__FILE__), "..", "public", "stylesheets", "admin.css"), File.join(".", "public", "stylesheets", "admin.css")
    FileUtils.cp File.join(File.dirname(__FILE__), "..", "public", "javascripts", "rails.js"), File.join(".", "public", "javascripts", "rails.js")
    FileUtils.cp File.join(File.dirname(__FILE__), "..", "public", "javascripts", "ichiban.js"), File.join(".", "public", "javascripts", "ichiban.js")
  end
end
