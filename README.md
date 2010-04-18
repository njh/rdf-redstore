# RedStore storage adapter for RDF.rb

This gem allows you to use a [RedStore](http://code.google.com/p/redstore/)
instance as a backend for RDF.rb.

Synopsis:

    require 'rdf'
    require 'rdf/redstore'

    repo = RDF::RedStore::Repository.new('http://localhost:8080/')
    puts RDF::Writer.for(:ntriples).dump repo

    repo.load 'http://datagraph.org/jhacker/foaf.nt'
    repo.count
    # => 10
    # Note: not all of the RedStore storage backends support the count method

    subject = repo.first.subject
    subject_statements = repo.query(:subject => subject)
    subject_statements.size
    # => 7

    repo.delete(*subject_statements)
    repo.count
    # => 3

## Installation

The recommended method of installation is via RubyGems.

    $ sudo gem install rdf-redstore

## Resources

 * {RDF::RedStore::Repository}
 * <http://rdf.rubyforge.org> - RDF.rb's home page
 * <http://rdf.rubyforge.org/RDF/Repository.html> - RDF.rb's Repository documentation
 * <http://code.google.com/p/redstore/>
 * <http://github.com/njh/rdf-redstore/>

### Support

Please post questions or feedback to the [W3C-ruby-rdf mailing list][].

### Author
 * Nicholas J Humfrey | <njh@aelius.com>

### 'License'

This is free and unemcumbered software released into the public domain.  For
more information, see the accompanying UNLICENSE file.

If you're unfamiliar with public domain, that means it's perfectly fine to
start with this skeleton and code away, later relicensing as you see fit.


[W3C-ruby-rdf mailing list]:        http://lists.w3.org/Archives/Public/public-rdf-ruby/
