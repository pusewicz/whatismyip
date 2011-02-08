require 'sinatra/base'

class WhatIsMyIP < Sinatra::Base
  VERSION = "1.0.0"

  set :public, File.expand_path('../public', __FILE__)
  set :views,  File.expand_path('../public', __FILE__)
  set :env,    :production

  before do
    response.headers['X-Application'] = server_info.first
    response.headers['X-Version']     = server_info.last

    response.headers['Expires']       = "-1"
    response.headers['Server']        = server_name

    response.headers['Cache-Control'] = 'private, max-age=0'
  end

  get "/" do
    content_type 'text/plain', :charset => 'utf-8'
    extract_remote_ip
  end

  private
  def extract_remote_ip
    request.ip || request.env['HTTP_X_REAL_IP'] || request.env['REMOTE_ADDR']
  end

  def server_info
    [self.class.name, VERSION]
  end

  def server_name
    server_info.join('/')
  end
end
