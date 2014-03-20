require 'bundler/gem_tasks'
require 'rake/clean'
require 'rake/testtask'

begin
  Bundler.setup :default, :development
rescue Bundler::BundlerError => error
  $stderr.puts error.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit error.status_code
end

Bundler::GemHelper.install_tasks

desc 'Run unit tests'
Rake::TestTask.new do |config|
  config.libs << 'lib' << 'test'
  config.pattern = 'test/**/test_*'
  config.verbose = true
  config.warning = true
end

desc 'Run tests'
task default: :test
