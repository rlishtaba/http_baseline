# * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - *
#
# Example:
#
#  * I set headers:
#    | Content-Type | application/json |
#    | X-roam-auth  | token            |
#
Given /^I set headers:$/ do |headers|
  headers.rows_hash.each { |k, v| connection.add_header k, v }
end


# * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - *
#
# Example:
#
#  * I send and accept JSON
#  * I send and accept XML
#  * I send and accept HTML
#
Given /^I send and accept (XML|JSON|HTML)$/ do |type|
  case type
    when 'XML', 'JSON'
      connection.add_header 'Accept', "application/#{type.downcase}"
      connection.add_header 'Content-Type', "application/#{type.downcase}"
    when 'HTML'
      connection.add_header 'Accept', 'text/html'
    else
      nil
  end
end


# * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - *
#
# Example:
#
#  * the HttpBaseline response should have headers:
#    | Accept | text/xml |
#
Then /^the HttpBaseline response should have headers:$/ do |table|
  hashed = table.rows_hash

  hashed.each_pair do |key, expected|

    actual = @response.headers[key.downcase]

    if self.respond_to?(:should)
      actual.should == expected
    else
      assert_equal actual, expected
    end
  end

end
