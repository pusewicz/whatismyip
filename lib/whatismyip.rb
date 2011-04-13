require 'sinatra/base'
require 'logger'

class WhatIsMyIP < Sinatra::Base
  eval File.read('lib/logic.rb')
end
