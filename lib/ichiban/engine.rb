module Ichiban
  class Engine < Rails::Engine
    initializer "static assets" do |app|
      app.middleware.use ::ActionDispatch::Static, "#{File.dirname(__FILE__)}/../../public"
    end
  end
end
