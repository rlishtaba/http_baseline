# * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - *
#
# Example:
#
#   * show me the response
#
Then /^show me the response$/ do
  $stdout.puts '------------- show me the response ------------- '

  if @response.headers['Content-Type'] =~ /json/
    $stdout.puts JSON.pretty_generate(@response.body)
  elsif @response.headers['Content-Type'] =~ /xml/
    $stdout.puts Nokogiri::XML(@response.body.to_s)
  else
    $stdout.puts @response.headers.to_hash
    $stdout.puts @response.body
  end

  $stdout.puts '------------- end of show me the response ------ '
end

# * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - *
#
# Example:
#
#   * show me the headers
#
Then /^show me the headers/ do
  $stdout.puts '------------- show me the headers ------------- '

  $stdout.puts JSON.pretty_generate @response.headers

  $stdout.puts '------------- end of show me the headers ------ '
end