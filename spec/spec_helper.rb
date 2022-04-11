# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require 'pathname'
require_relative '../lib/whatismyip'

root_path = Pathname.new(File.expand_path('..', __dir__))
Dir[root_path.join('spec/support/**/*.rb')].each { |f| require f }
