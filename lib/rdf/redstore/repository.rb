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
    def initialize(options_or_uri = {})
      case options_or_uri
        when Hash
          @settings = options_or_uri.dup
          @uri = @settings[:uri].to_s
        else
          @settings = {}
          @uri = options_or_uri.to_s
      end
      super(uri_for(:query), @settings)
    end

    # @private
    def count
      uri = uri_for(:description)
      description = RDF::Graph.load(uri, :format => :ntriples)
      total = description.first_value(:predicate => SD.totalTriples)
      if total.nil? or total.to_i < 0
        nil
      else
        total.to_i
      end
    end
    alias_method :size, :count
    alias_method :length, :count

    # @private
    def insert_statement(statement, opts = {})
      insert_statements([statement], opts)
    end

    # @private
    def insert_statements(statements, opts = {})
      post_statements(:insert, statements, opts)
    end

    # @private
    def delete_statement(statement, opts = {})
      if statement.invalid?
        delete_statements(query(statement), opts)
      else
        delete_statements([statement], opts)
      end
    end

    # @private
    def delete_statements(statements, opts = {})
      post_statements(:delete, statements, opts)
    end

    # @private
    def clear_statements
      uri = uri_for(:data)
      Net::HTTP.start(uri.host, uri.port) do |http|
        http.delete(uri.path).code == '200'
      end
    end

    def writable?
      true
    end

    # @private
    def uri_for(action)
      RDF::URI.parse(@uri+action.to_s)
    end
    
    # @private
    def post_statements(action, statements, opts = {})
      graph = RDF::Graph.new
      graph.insert_statements(statements)
      content = RDF::Writer.for(:ntriples).dump(graph)

      uri = uri_for(action)
      req = Net::HTTP::Post.new(uri.path)
      req.form_data = {
        'content' => content,
        'content-type' => 'ntriples',
        'graph' => opts[:context].to_s
      }

      Net::HTTP.start(uri.host, uri.port) do |http|
        response = http.request(req)
        response.code == '200'
      end
    end
    
  end
end
