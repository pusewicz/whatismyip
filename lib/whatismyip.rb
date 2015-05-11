require 'sinatra/base'
require 'json'

class WhatIsMyIP < Sinatra::Base
  VERSION = "1.1.0"

  set :public_folder, File.expand_path('../public', __FILE__)
  set :views,  File.expand_path('../public', __FILE__)
  set :env,    :production

  before do
    response.headers['Application'] = server_info.first
    response.headers['Version']     = server_info.last

    response.headers['Expires']       = "-1"
    response.headers['Server']        = server_name

    response.headers['Cache-Control'] = 'private, max-age=0'
  end

  get '/' do
    extracted_ip = extract_remote_ip

    request.accept.each do |type|
      case type.to_s
      when 'text/html'
        halt slim(:index, locals: { ip: extracted_ip, title: server_name })
      when 'text/json', 'application/json'
        halt %("#{extracted_ip}")
      when 'text/plain'
        halt extracted_ip
      end
    end
    error 406
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
