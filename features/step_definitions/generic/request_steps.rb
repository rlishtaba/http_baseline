# * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - *
#
# Example
#
#    *  I send a :get request to "/user/login" with the following:
#        | userId   | user     |
#        | password | password |
#
When /^I send a :(get|post|put|delete) request (?:for|to) "([^"]*)"(?: with the following:)?$/ do |*args|
  request_type = args.shift
  path         = args.shift
  input        = args.shift
  request_opts = {}

  unless input.nil?
    if input.class == Cucumber::Ast::Table # table
      request_opts.merge!(input.rows_hash)
    else # lines
      request_opts.merge!(input)
    end
  end

  request_opts.each do |key, value|
    if value =~ /\@default_(token|user|password)/
      request_opts[key] = HttpBaseline.config.comm.http.send($1)
    end
  end

  transmit(request_type, path, request_opts)
end

# * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - *
#
# Example:
#
#   * I send Form Data via :post request to "/user/changePassword" with the following:
#      | userId      | user            |
#      | oldPassword | fibonacci_123   |
#      | newPassword | fibonacci_12358 |
#
#
Given /^I send Form Data via :(post|put) request (?:for|to) "([^"]*)" with the following:$/ do |request_type, path, raw_table|
  request_opts = sub_to_default_credentials(raw_table.rows_hash.dup)

  step 'I set headers:', table('| Content-Type | application/x-www-form-urlencoded |')

  transmit(request_type, path, request_opts.to_query)
end


# * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - * - *
#
# Example:
#
#   * I send Form Data via :post request to "/user/changePassword" with the following raw body:
#      """
#       {
#         "hello": "world"
#       }
#      """
When /^I send a :(post|put) request (?:for|to) "([^"]*)" with the following raw body:$/ do |*args|
  request_type = args.shift
  path         = args.shift
  body         = args.shift

  set_headers_by(body.content_type)

  transmit(request_type, path, body.lines.to_a.join("\n").dup)
end