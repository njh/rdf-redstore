require 'rdf'
require 'sparql/client'
require 'net/http'
require 'enumerator'

module RDF::RedStore

  SD = RDF::Vocabulary.new("http://www.w3.org/ns/sparql-service-description#")

  ##
  # An RDF::Repository backend for RedStore.
  #
  # @see http://rdf.rubyforge.org/RDF/Repository.html
  class Repository < ::SPARQL::Client::Repository

    ##
    # Create a new RDF::RedStore::Repository.
    #
    # @param [String] uri
    # @param [Hash] opts
    # @return [RDF::RedStore::Repository]
    # @example
    #     RDF::RedStore::Repository.new('http://localhost:8080/')
    #
    def initialize(url, options = {})
      @url      = url
      @settings = options.dup
      super(@url+'query', @settings)
    end

    # @private
    def count
      url = RDF::URI.parse(@url+'description')
      description = RDF::Repository.load(url, :format => :ntriples)
      result = description.query(:predicate => SD.totalTripless)
      unless result.empty?
        result.first.object.value.to_i
      end
    end
    alias_method :size, :count
    alias_method :length, :count

    # @private
    def insert_statement(statement)
      raise NotImplementedError
    end

    # @private
    def insert_statements(statements, opts = {})
      raise NotImplementedError
    end

    # @private
    def delete_statement(statement)
      if statement.invalid?
        delete_statements(query(statement))
      else
        raise NotImplementedError
      end
    end

    # @private
    def delete_statements(statements, opts = {})
      return true if statements.empty?
      raise NotImplementedError
    end

    # @private
    def clear_statements
      raise NotImplementedError
    end

    def writable?
      true
    end

  end
end
