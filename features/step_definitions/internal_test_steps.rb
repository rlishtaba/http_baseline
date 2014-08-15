When /^I perform the following steps?:$/ do |step_strings|
  steps = step_strings.split("\n")
  steps.each { |step_string| step step_string.strip }
end

Then /^the response should equal:$/ do |response_body|
  @response.body.should eq(response_body)
end

When /^I perform the following step with table:$/ do |step_definition|
  lines       = step_definition.split("\n")
  step_string = lines.shift.strip

  raw = lines.map do |line|
    line.squish.gsub(/^\|/, '').gsub(/\|$/, '').squish.split("|").map(&:squish)
  end

  step step_string.strip, table(raw)
end

When /^I perform the following step with string:$/ do |step_definition|
  lines       = step_definition.split("\n")
  step_string = lines.shift

  param_string = lines.join("\n")

  step step_string.strip, param_string
end

Then /^the request headers should be:$/ do |headers|
  headers_hash = headers.rows_hash
  request '/'
  @stack.env.slice(*headers_hash.keys).values.should eq(headers_hash.values)
end

Then /^I should be authenticated$/ do
  @response.env["HTTP_AUTHORIZATION"].should eq("Basic #{Base64.encode64("roman:lishtaba")}")
end

Then /^I should be digest authenticated$/ do
  @response.env["HTTP_AUTHORIZATION"].starts_with?("Digest ").should be_true
end
