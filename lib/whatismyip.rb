require 'sinatra/base'

class WhatIsMyIP < Sinatra::Base
  VERSION = "1.0.0"

  set :public, File.expand_path('../public', __FILE__)
  set :views,  File.expand_path('../public', __FILE__)
  set :env,    :production

  before do
    header 'X-Version' => VERSION
  end

  get "/" do
    content_type 'text/plain', :charset => 'utf-8'
    extract_remote_ip
  end

  private
  def extract_remote_ip
    request.env['HTTP_X_REAL_IP'] || request.env['REMOTE_ADDR']
  end
end
