module RDF::RedStore
  module VERSION
    MAJOR = 0
    MINOR = 1
    TINY  = 0
    EXTRA = nil

    STRING = [MAJOR, MINOR, TINY].join('.')
    STRING << "-#{EXTRA}" if EXTRA

    ##
    # @return [String]
    def self.to_s()   STRING end

    ##
    # @return [String]
    def self.to_str() STRING end
  end
end
