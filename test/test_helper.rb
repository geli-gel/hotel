require "simplecov"
SimpleCov.start do
  add_filter 'test/'
end
require "minitest"
require "minitest/autorun"
require "minitest/reporters"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# require_relative your lib files here!
require_relative '../lib/management_system.rb'
require_relative '../lib/reservation.rb'
require_relative '../lib/room.rb'
require_relative '../lib/block.rb'
