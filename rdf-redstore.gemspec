#!/usr/bin/env ruby -rubygems
# -*- encoding: utf-8 -*-

GEMSPEC = Gem::Specification.new do |gem|
  gem.version            = File.read('VERSION').chomp
  gem.date               = File.mtime('VERSION').strftime('%Y-%m-%d')

  gem.name               = 'rdf-redstore'
  gem.homepage           = 'http://rdf.rubyforge.org/'
  gem.license            = 'Public Domain' if gem.respond_to?(:license=)
  gem.description        = 'RDF.rb plugin providing a RedStore storage adapter.'
  gem.summary            = 'RDF.rb plugin providing a RedStore storage adapter.'
  gem.rubyforge_project  = 'rdf'

  gem.authors            = ['Nicholas J Humfrey']
  gem.email              = 'njh@aelius.com'

  gem.platform           = Gem::Platform::RUBY
  gem.files              = %w(AUTHORS README UNLICENSE VERSION) + Dir.glob('lib/**/*.rb')
  gem.bindir             = %q(bin)
  gem.executables        = %w()
  gem.default_executable = gem.executables.first
  gem.require_paths      = %w(lib)
  gem.extensions         = %w()
  gem.test_files         = %w()
  gem.has_rdoc           = false

  gem.required_ruby_version      = '>= 1.8.2'
  gem.requirements               = []
  gem.add_runtime_dependency     'rdf',          '>= 0.1.9'
  gem.add_runtime_dependency     'sparql-client','>= 0.0.3'
  gem.add_development_dependency 'rdf-spec',     '>= 0.1.6'
  gem.add_development_dependency 'rspec',        '>= 1.3.0'
  gem.add_development_dependency 'yard' ,        '>= 0.5.3'
  gem.post_install_message       = nil
end
