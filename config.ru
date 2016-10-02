require 'rack/jekyll'
require 'yaml'

use AcmeChallenge, ENV['ACME_CHALLENGE'] if ENV['ACME_CHALLENGE']
run Rack::Jekyll.new
