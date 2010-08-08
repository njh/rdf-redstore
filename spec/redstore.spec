require File.dirname(__FILE__) + "/spec_helper.rb"

require 'rdf/spec/repository'
require 'rdf/redstore'

$redstore_port, $redstore_pid = start_redstore()

describe RDF::RedStore::Repository do
  context "RedStore" do
    before :each do
      @repository = RDF::RedStore::Repository.new(
        "http://localhost:#{$redstore_port}/"
      )
    end
   
    after :each do
      @repository.clear
    end

    # @see lib/rdf/spec/repository.rb in RDF-spec
    it_should_behave_like RDF_Repository
  end

end


END {
  puts "** Killing RedStore process #{$redstore_pid}"
  stop_redstore($redstore_pid)
  true
}
