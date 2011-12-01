require "bundler/gem_tasks"
require 'rake/testtask'

task :test do
  Rake::TestTask.new do |t|
    Dir['test/*_test.rb'].each{|f| require File.expand_path(f)}
  end
end
