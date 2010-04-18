$:.unshift File.dirname(__FILE__) + "/../lib/"

require 'rdf'
require 'rdf/spec/repository'
require 'rdf/redstore'

describe RDF::RedStore::Repository do
  context "RedStore" do
    before :each do
      @repository = RDF::RedStore::Repository.new() # TODO: Do you need constructor arguments?
    end
   
    after :each do
      #TODO: Anything you need to clean up a test goes here.
      @repository.clear
    end

    # @see lib/rdf/spec/repository.rb in RDF-spec
    it_should_behave_like RDF_Repository
  end

end

