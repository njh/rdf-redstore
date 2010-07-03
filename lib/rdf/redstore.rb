require 'rdf'

module RDF
  ##
  # **`RDF::RedStore`** is a RedStore adapter for RDF.rb.
  #
  # Dependencies
  # ------------
  #
  # * [RDF.rb](http://rubygems.org/gems/rdf) (>= 0.1.0)
  # * [SPARQL::Client](http://rubygems.org/gems/sparql-client) (>= 0.0.3)
  #
  # Installation
  # ------------
  #
  # The recommended installation method is via RubyGems. To install the latest
  # official release, do:
  #
  #     % [sudo] gem install rdf-redstore
  #
  # Documentation
  # -------------
  #
  # * {RDF::RedStore::Repository}
  #
  # @example Requiring the `RDF::RedStore` module
  #   require 'rdf/redstore'
  #
  # @see http://rdf.rubyforge.org/
  # @see http://www.aelius.com/njh/redstore/
  #
  # @author [Nicholas J Humfrey](http://www.aelius.com/njh/)
  module RedStore
    autoload :Repository, 'rdf/redstore/repository'
    autoload :VERSION,    'rdf/redstore/version'
  end
end
