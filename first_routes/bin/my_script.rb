require "addressable/uri"
require "rest-client"

user_details = { :contact =>
    {
      :email => "jiang@gmail.com"
    }
  }

url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/users/1.html'
  # :query_values => {
#     "var1" => "a",
#     "var2" => "b",
#     "var3" => "z"
#   }
).to_s

puts RestClient.get(url, user_details)
