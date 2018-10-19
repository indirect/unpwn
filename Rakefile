require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "http"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :build => %w[src/top1000000 lib/top1000000.msgpack]

file "lib/top1000000.msgpack" => %w[src/top1000000] do
  ruby %{-rbloomer -rbloomer/msgpackable -e '
    b=Bloomer.new(1_000_000, 0.001)
    File.read("src/top1000000").split("\n").each{|p| b.add(p) }
    File.write("lib/top1000000.msgpack", b.to_msgpack)
  '}
end

file "src/top1000000" => %w[src] do
  puts "getting src/top1m"
  url = "https://github.com/cry/nbp/raw/master/build_collection/top1000000"
  File.write "src/top1000000", HTTP.follow.get(url).body
end

directory "src"
