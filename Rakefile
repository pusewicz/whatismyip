begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)

  task :default => :spec
rescue LoadError
  # no rspec available
end

require 'rake/clean'

CLEAN.include("assets/water.css", "assets/style.css")

desc "Update style.min.css"
file "assets/style.min.css" => "assets/style.css" do |t|
  system("csso assets/style.css --output #{t.name}")
end

file "assets/style.css" => "assets/water.css" do |t|
  system("purgecss --css assets/water.css --content views/*.slim --output #{t.name}")
end

file "assets/water.css" do |t|
   require 'open-uri'
   image_url = "https://cdn.jsdelivr.net/npm/water.css@2/out/water.css"
   IO.copy_stream(URI.open(image_url), t.name)
end
