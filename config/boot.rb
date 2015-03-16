RACK_ENV = ENV['RACK_ENV'] ||= 'development' unless defined?(RACK_ENV)
require 'bundler'
Bundler.setup(:default, RACK_ENV)
require File.expand_path '../database', __FILE__

require 'rack/unreloader'
require 'active_support'
Unreloader = Rack::Unreloader.new(reload: true, logger: Logger.new(STDOUT)) do
  App
end
Unreloader.require('models') {|f| File.basename(f).sub(/\.rb\z/, '').classify}

def reload!() Unreloader.reloader.reload! end
