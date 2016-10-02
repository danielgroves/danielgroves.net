require 'rack/jekyll'
require 'yaml'
require 'letscencrypt_rack'

run Rack::Jekyll.new
