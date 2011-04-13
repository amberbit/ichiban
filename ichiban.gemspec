# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name = "ichiban"
  s.summary = "Insert Ichiban summary."
  s.description = "Insert Ichiban description."
  s.files = Dir["lib/**/*", "app/**/*", "config/**/*", "tasks/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.version = "0.0.1"
end
