$LOAD_PATH.unshift(File.expand_path('lib', File.dirname(__FILE__)))

require 'whatismyip'

run WhatIsMyIP.freeze.app
