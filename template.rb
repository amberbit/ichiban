require 'open-uri'

run "rm Gemfile"

file "Gemfile", <<-CODE
source 'http://rubygems.org'

gem 'rails', :git => 'git://github.com/rails/rails.git'
gem "mongoid", ">= 2.0.0.beta9"
gem "bson_ext", "1.0.1", require: nil
gem "haml", "3.0.13"
gem "devise", "1.1.rc2"
gem "carrierwave", git: "git://github.com/jnicklas/carrierwave.git"
gem "rmagick", "2.13.1", require: "RMagick"
gem "rdiscount", "1.6.5"
gem "ichiban", git: "git://github.com/amberbit/ichiban.git"

gem "rspec", "2.0.0.beta.15", require: nil
gem "rspec-rails", "2.0.0.beta.15", require: nil
gem "steak", git: "git://github.com/cavalle/steak.git", require: nil
gem "capybara", "0.3.9", require: nil
CODE

db_name = nil
while db_name.blank?
  db_name = ask("\r\n\r\nWhat should I call the database?\r\n\r\n(Leave blank to use application name)")
end
file "config/mongoid.yml", <<-CODE
defaults: &defaults
  use_object_ids: false
  host: localhost

test:
  <<: *defaults
  database: #{db_name}_test

development:
  <<: *defaults
  database: #{db_name}_development
CODE

str = ""
File.open("config/application.rb", "r") do |f|
  str = f.read
end

str.gsub!("require 'rails/all'", "require \"action_controller/railtie\"\nrequire \"action_mailer/railtie\"")

File.open("config/application.rb", "w+") do |f|
  f.write str
end

%w{controls.js dragdrop.js effects.js prototype.js rails.js}.each { |f| run "rm public/javascripts/#{f}"}

puts run("bundle install")

open("http://github.com/amberbit/ichiban/raw/master/public/javascripts/ichiban.js", "r") do |f|
  File.open("public/javascripts/ichiban.js", "w+") do |out|
    out.write f.read
  end
end

open("http://github.com/amberbit/ichiban/raw/master/public/javascripts/rails.js", "r") do |f|
  File.open("public/javascripts/rails.js", "w+") do |out|
    out.write f.read
  end
end

open("http://github.com/amberbit/ichiban/raw/master/public/images/amberbit.png", "r") do |f|
  File.open("public/images/amberbit.png", "w+") do |out|
    out.write f.read
  end
end

open("http://github.com/amberbit/ichiban/raw/master/public/stylesheets/reset.css", "r") do |f|
  File.open("public/stylesheets/reset.css", "w+") do |out|
    out.write f.read
  end
end

open("http://github.com/amberbit/ichiban/raw/master/public/stylesheets/admin.css", "r") do |f|
  File.open("public/stylesheets/admin.css", "w+") do |out|
    out.write f.read
  end
end




