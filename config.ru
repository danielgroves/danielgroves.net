require 'rack/jekyll'
require 'rack/rewrite'
require 'yaml'
require 'acme_challenge'

use AcmeChallenge, ENV['ACME_CHALLENGE'] if ENV['ACME_CHALLENGE']

use Rack::Rewrite do
  # Ensure all traffic comes through HTTPS in production
  if ENV['RACK_ENV'] == 'production'
    r301 %r{.*}, 'https://danielgroves.net$&', :scheme => 'http'
  end

  r301 '/adventures-photography/2014/11/JOGLE-2/', '/adventures-photography/2014/12/JOGLE-2/$&'
  r301 '/adventures-photography/2014/10/JOGLE/', '/adventures-photography/2014/11/JOGLE/'
  r301 %r{/([0-9]{4})/([0-9]{2})}, '/notebook'
  r301 %r{/notebook/page/(.*)}, '/notebook/$1'
  r301 %r{/page/(.*)}, '/notebook/$1'
  r301 '/tag', '/notebook'
  r301 '/category', '/notebook'
  r301 %r{/camera-roll/(.*)$}, '/adventures-photography/$1'
  r301 '/camera-roll', '/adventures-photography'
  r301 %r{/feed/camera-roll/(.*)}, '/feed/adventures-photography/$1'
  r301 '/feed/camera-roll', '/feed/adventures-photography/'
end

run Rack::Jekyll.new
