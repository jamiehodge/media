# encoding: utf-8
require File.dirname(__FILE__) + '/lib/media/version'

Gem::Specification.new do |gem|
  gem.name        = 'media'
  gem.version     = Media::VERSION
  gem.authors     = ['Jamie Hodge']
  gem.email       = ['jamiehodge@me.com']
  gem.summary     = 'FFMPEG/AVConv wrapper'
  gem.description = gem.summary
  gem.homepage    = 'https://github.com/jamiehodge/media'
  
  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.require_paths = ['lib']
  
  gem.add_dependency 'yajl-ruby'
  
  gem.add_development_dependency('rake')
  gem.add_development_dependency('minitest')
end