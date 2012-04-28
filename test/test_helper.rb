require 'rubygems'
require 'spork'
# require 'spork/ext/ruby-debug'

Spork.prefork do
  ENV["RAILS_ENV"] = "test"
  require File.expand_path('../../config/environment', __FILE__)
  require 'rails/test_help'
  require 'turn'

  class ActiveSupport::TestCase
    include Devise::TestHelpers
  end
end

Spork.each_run do
end
