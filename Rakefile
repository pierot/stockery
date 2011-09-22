# encoding: utf-8

require 'rubygems'
require 'bundler'
require 'rake'
require 'jeweler'
require 'rdoc/task'
require 'rcov/rcovtask'
require 'rake/testtask'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

Jeweler::Tasks.new do |gem|
  gem.name = "stockery"
  gem.homepage = "http://github.com/pierot/stockery"
  gem.license = "MIT"
  gem.summary = %Q{Fetch stock quotes}
  gem.description = %Q{Fetch stock quotes. Build as a gem and command line tool.}
  gem.email = "pieter@noort.be"
  gem.authors = ["Pieter Michels"]
  gem.add_development_dependency "thoughtbot-shoulda", ">= 0"
end
Jeweler::RubygemsDotOrgTasks.new

Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

Rcov::RcovTask.new do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
  test.rcov_opts << '--exclude "gems/*"'
end

task :default => :test

Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "Stockery #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
