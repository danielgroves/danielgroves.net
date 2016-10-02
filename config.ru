require 'rack/jekyll'
require 'yaml'
require 'acme_challenge'

use AcmeChallenge, ENV['ACME_CHALLENGE'] if ENV['ACME_CHALLENGE']

run Rack::Jekyll.new
