# HTTP

### Status
[![Build Status](https://travis-ci.org/rlishtaba/http_baseline.svg?branch=master)](https://travis-ci.org/rlishtaba/http_baseline.svg?branch=master)

## Installation

Add this line to your application's Gemfile:

    gem 'http_baseline'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install http_baseline

## Usage in terms of Cucumber

Here is :

### Steps examples for HTTP headers:

    Given I set headers:
     |Set-Cookie| my secret cookie |

    Given I send and accept JSON

    Given I send and accept XML

    Given I send and accept HTML

    Given the HTTP response should have header "Set-Cookie" with value "server side secret cookie"

    Given the HTTP response should have headers:
     | Accept | text/xml |

    Given the JSON response should have default headers


### Steps to handle requests or responses:

     Given I send a :put request to "/open"

     Given I send a :put request to "/open" with the following:
       |timeout| 15 |

     Then the response status should be "404"

     And the JSON response should have "$..Message" with the text "Invalid communication setting"

     And the JSON response should have "$..Message" with the regexp "Invalid communication setting.+?"

     And the XML response should have "Message" with the text "Invalid communication setting"

     Then show me the response

     Then show me the headers

