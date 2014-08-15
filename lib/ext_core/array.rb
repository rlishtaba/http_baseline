class Array
  # Converts an array into a string suitable for use as a URL query string,
  # using the given +key+ as the param name.
  #
  #   ['Ruby', 'coding'].to_query('hobbies') # => "hobbies%5B%5D=Ruby&hobbies%5B%5D=coding"
  def to_query(key)
    prefix = "#{key}[]"
    collect { |value| value.to_query(prefix) }.join '&'
  end
end