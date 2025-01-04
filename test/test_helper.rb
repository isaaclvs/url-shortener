ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/reporters'
require 'rack/test'

Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(color: true)]

require_relative '../db/db'
require_relative '../app/controllers/app'
require_relative '../app/models/url' 