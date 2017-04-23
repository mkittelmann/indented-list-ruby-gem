require 'indented-list/indented-list-parser'
require 'pp'
 
  #
  # Parses whitespace indented nested list.
  # The parsing result is an object of Hashes of Array, hence the list can easily be converted to JSON or YAML.
  #
  #
  # == Getting started 
  #      require 'indented-list'
  #      list = IndentedList.new( 'list.txt' )  # load list from a text file
  #      list = IndentedList.new( my-list )     # list can be passed as Array or String
  #
  #
  # == Usage
  #
  # Full text search 
  # Returns full branch of the root Hash in which match has occured.
  #       pp list.find( /my-regex/ )  
  #
  #
  # == Extensibility
  #
  # This gem suggests the hook method 'get' which can be implemented as needed for any specific list. 
  # Any other list-specific method can be easily implemented. 
  #   class MyList < IndentedList
  #     def get( *params )
  #       get_tags_with_indicators
  #     end
  #
  #     def get_tags_with_indicators
  #       # ...
  #     end
  #   end
  #
  #
  # == CLI Usage
  #
  # For use with IRB suppress return output:
  #       irb(main):001:0> irb --simple-prompt --noecho
  #
  # You can also suppress return output in irb on a by-line basis:
  #       irb(main):001:0> marc = MARC21Format.new;0    # => 0
  #
  # Commands can then be used as described above.
  #
  # ---
  #
  # Copyright (c) 2017 Maike Kittelmann
  #
  # Indented-List is freely distributable under the terms of MIT license.
  # See LICENSE file or http://www.opensource.org/licenses/mit-license.php
  #
  # Disclaimer: The software comes without any warranty.
  
  
class IndentedList
  attr_reader :list

  def initialize( list )
    parser = IndentedListParser.new( list )
    @list = parser.list
  end
  
  def each( &block )
    list.each( &block )
  end
  
  def method_missing( method, *args, &block )
    list.respond_to?( method, *args, &block ) ? list.send( method, *args, &block ) : super
  end  
  
  #
  # Full text search. Takes a regular expression as an argument. 
  # Returns full branch of the root Hash in which match has occured.
  #  
  def find( regex )
    list.select { |k,v| { k => v } if ( k.match( regex ) || v.to_s.match( regex ) ) } 
  end
  
  #
  # Hook
  #
  def get( *params )
    puts 'Implement specific searches for your list. See documentation for how to do this.'
  end
  
end
