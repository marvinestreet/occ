ENV['APP_ENV'] = 'test'
ENV['DATABASE_URL'] ||= 'postgres://postgres:postgres@localhost:5432/postgres'
# Rack::Test sends requests with Host: example.org; allowlist it so the
# host_authorization middleware in app.rb doesn't 403 every test.
ENV['PERMITTED_HOSTS'] = 'example.org'

require 'minitest/autorun'
require 'minitest/mock'
require 'rack/test'

require_relative '../app'
