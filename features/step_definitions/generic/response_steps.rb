# * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - *
#
# Example:
#
#   * the response code should be "404"
#
Then /^the response (code|status) should be "([^"]*)"$/ do |_, code|
  if self.respond_to? :should
    @response.status.should == code.to_i
  else
    assert_equal code, @response.code
  end
end


# * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - *
#
# Example:
#
#   * the JSON response should have "userId" matching with "[a-zA-Z0-9_-]{3,50}"
#
Then /^the JSON response should (not)?\s?have "([^"]*)" matching with "((?!["]).*)"$/ do |*options|
  negative      = options.shift
  json_path     = options.shift
  regexp_string = options.shift
  regexp        = Regexp.compile("^#{regexp_string}$", Regexp::IGNORECASE)
  raw_json      = @response.body
  results       = JsonPath.new(json_path).on(raw_json).to_a.map(&:to_s)

  if !negative.nil?
    results.first.should_not =~ regexp
  else
    results.first.should =~ regexp
  end

end


# * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - *
#
# Example:
#
#   * the JSON response should have "errCode" with the text "SYSTEM_ERROR"
#
Then /^the JSON response should (not)?\s?have "([^"]*)" with the text "((?!["]).*)"$/ do |negative, json_path, text|
  json    = @response.body
  results = JsonPath.new(json_path).on(json).to_a.map(&:to_s)

  if self.respond_to?(:should)
    if negative.nil?
      results.should include(text)
    else
      results.should_not include(text)
    end
  else
    if negative.nil?
      assert results.include?(text)
    else
      assert !results.include?(text)
    end
  end
end


# * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - *
#
# Example:
#
#   * the XML response should have "errCode" with the text "SYSTEM_ERROR"
#
Then /^the XML response should have "([^"]*)" with the text "((?!["]).*)"$/ do |xpath, text|
  parsed_response = Nokogiri::XML(@response.body.to_s)
  elements        = parsed_response.xpath(xpath)
  if self.respond_to?(:should)
    elements.should_not be_empty, "could not find #{xpath} in:\n#{@response.body.to_s}"
    elements.find { |e| e.text == text }.should_not be_nil, "found elements but could not find #{text} in:\n#{elements.inspect}"
  else
    assert !elements.empty?, "could not find #{xpath} in:\n#{@response.body.to_s}"
    assert elements.find { |e| e.text == text }, "found elements but could not find #{text} in:\n#{elements.inspect}"
  end
end

# * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - *
#
# Example:
#
#   * the JSON response should match:
#   """
#   {
#      "tspUser": {
#          "address": {
#              "address1": "aaa",
#              "address2": "bbb",
#              "address3": "ccc",
#              "city": "Boston",
#              "country": "US",
#              "fullAddress": "fullAddress",
#              "id": "909",
#              "postal": "200231",
#              "state": "MA"
#             }
#        }
#   }
#   """
#
Then 'the JSON response should match:' do |json|
  expected = JSON.parse(json)
  actual   = @response.body

  if self.respond_to?(:should)
    actual.should == expected
  else
    assert_equal actual, response
  end
end


# * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - *
#
# Example:
#
# * the JSON response should have "address" node with a elements counter matching to "10"
#
#
Then /^the JSON response should have "([^"]*)" node with a elements counter matching to "(\d+)"$/ do |json_path, length|
  json    = @response.body
  results = JsonPath.new(json_path).on(json)
  if self.respond_to?(:should)
    results.length.should == length.to_i
  else
    assert_equal length.to_i, results.length
  end
end