require 'acme_challenge'
require 'rack/robotz'
require 'rack/rewrite'
require 'rack/deflater'
require 'rack/contrib/try_static'
require 'rack/anystatus'

use AcmeChallenge, ENV['ACME_CHALLENGE'] if ENV['ACME_CHALLENGE']
use Rack::Robotz, "User-Agent" => "*", "Disallow" => "/" unless ENV['RACK_ENV'] == 'production'

map '/favicon.ico' do
  run Rack::Anystatus::Endpoint.new 404, 'build/404.html'
end

map '/apple-touch-icon-precomposed.png' do
  run Rack::Anystatus::Endpoint.new 404, 'build/404.html'
end

map '/apple-touch-icon.png' do 
  run Rack::Anystatus::Endpoint.new 404, 'build/404.html'
end

map '/apple-touch-icon-152x152.png' do
  run Rack::Anystatus::Endpoint.new 404, 'build/404.html'
end

map '/apple-touch-icon-152x152-precomposed.png' do
  run Rack::Anystatus::Endpoint.new 404, 'build/404.html'
end

use Rack::Rewrite do
  if ENV['RACK_ENV'] == 'production'
   r301 %r{.*}, 'https://danielgroves.net$&', :scheme => 'http'
  end

  r301 '/adventures-photography/2014/11/JOGLE-2/', '/adventures-photography/2014/12/JOGLE-2/$&'
  r301 '/adventures-photography/2014/10/JOGLE/', '/adventures-photography/2014/11/JOGLE/'
  r301 %r{^/([0-9]{4})/([0-9]{2})}, '/notebook'
  r301 %r{^/notebook/page/(.*)}, '/notebook/$1'
  r301 %r{^/page/(.*)}, '/notebook/$1'
  r301 '/tag', '/notebook'
  r301 '/category', '/notebook'
  r301 %r{^/camera-roll/(.*)$}, '/adventures-photography/$1'
  r301 '/camera-roll', '/adventures-photography'
  r301 %r{^/feed/camera-roll/(.*)}, '/feed/adventures-photography/$1'
  r301 '/feed/camera-roll', '/feed/adventures-photography/'
end

use Rack::Deflater
use Rack::TryStatic,
  urls: %w[/],
  root: 'build',
  try: ['.html', 'index.html', '/index.html', 'index.xml', '/index.xml'],
  header_rules: [
    [:all, {
      'Strict-Transport-Security' => 'max-age=31536000; preload',
      'X-Xss-Protection' => '1; mode=block',
      'X-Content-Type-Options' => 'nosniff',
      'X-Frame-Options' => 'DENY',
      'Content-Security-Policy' => "default-src 'self'; font-src data: https://fonts.typekit.net https://use.typekit.net https://pshubcdn.blob.core.windows.net; img-src 'self' https://danielgroves-net.imgix.net https://danielgroves-net-2.imgix.net https://d1238u3jnb0njy.cloudfront.net https://p.typekit.net https://www.google-analytics.com; style-src 'self' 'unsafe-inline' https://d1238u3jnb0njy.cloudfront.net https://use.typekit.net; script-src 'self' 'unsafe-inline' https://d1238u3jnb0njy.cloudfront.net https://use.typekit.net https://www.google-analytics.com  https://hub.theprintspace.co.uk; child-src https://a.tiles.mapbox.com; frame-src https://a.tiles.mapbox.com  https://hub.theprintspace.co.uk; connect-src https://hub.theprintspace.co.uk"
    }],
    [['html'], { 'Content-Type' => 'text/html; charset=utf-8'}],
    [['css'], { 'Content-Type' => 'text/css'}],
    [['js'], { 'Content-Type' => 'text/javascript' }],
    [['png'], { 'Content-Type' => 'image/png' }],
    [['gif'], { 'Content-Type' => 'image/gif' }],
    [['jpeg'], { 'Content-Type' => 'image/jpeg' }],
    [['jpg'], { 'Content-Type' => 'image/jpeg' }],
    [['zip'], { 'Content-Type' => 'application/zip' }],
    [['pdf'], { 'Content-Type' => 'application/pdf' }],
    [['xml'], { 'Content-Type' => 'application/rss+xml' }],
    [['/assets'], { 'Cache-Control' => 'public', 'Vary' => 'Accept-Encoding' }]
  ]

  run lambda { |env|
    [404, { 'Content-Type' => 'text/html' }, File.open('build/404.html', File::RDONLY)]
  }
