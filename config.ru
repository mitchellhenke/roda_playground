require File.expand_path '../config/boot', __FILE__
Unreloader.require('app/app.rb'){|f| 'App' }
run Unreloader
