class IndentedListParser
  attr_reader :list, :raw

  #
  # Parses a whitespace indented nested list and returns its content as an object of nested Hashes and Arrays. 
  #
  def initialize( list )
    case list
      when String
        source = list && File.exist?( list ) ? File.readlines( list ) : list.lines
      when Array 
        source = list
      else
        abort "List can be given as a file name, String or Array. The class of the currently used list '#{list}' is: #{list.class}."
    end
    raw = source.map(&:chomp).select { |line|  line if !line.match(/^\s*$/) }
    @list = step raw
  end
 
  private

  def get_indentation_map( arr )
    arr.map { |line| line[/^ */].size }
  end

  def slice_before_smallest_indent( arr )
    indentation_map = get_indentation_map( arr ).uniq.sort
    smallest_indent = indentation_map[0]
    arr.slice_before { |line| line[/^ */].size == smallest_indent  }.to_a
  end

  def turn_nested_arr_into_hash( nested_arr )
    nested_arr.inject({}) { |hash, arr| hash = hash.merge( arr[0].strip => arr[1..-1] ) }
  end

  def step( arr )
    if arr.is_a?( Array ) && !arr.empty? && arr[0].is_a?( String )     
      if get_indentation_map( arr ).uniq.sort.count > 1 
        arr = slice_before_smallest_indent arr
        arr = turn_nested_arr_into_hash arr
        arr = arr.inject({}) do |hash, (key, value)|
          hash = hash.merge( key => step( value ) )
        end
      else
        arr = arr.map(&:strip)
      end
    else
      arr
    end
  end
    
end