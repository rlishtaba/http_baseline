Given /^I am logged in with the following credentials:$/ do |raw_table|
  step 'I send a :get request to "/user/login" with the following:', raw_table
  step 'the JSON response should have "status" with the text "success"'
end

Given /^I am logged in$/ do
  login_to_web_service
  step 'the response code should be "200"'
  step 'the JSON response should have "status" with the text "success"'
end

