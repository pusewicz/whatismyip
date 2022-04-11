# frozen_string_literal: true

require 'roda'

class WhatIsMyIP < Roda
  VERSION = "1.1.0"

  plugin :default_headers, {
    'Application' => self.class.name,
    'Version' => VERSION,
    'Expires'=> '-1',
    'Cache-Control' => 'private, max-age=0'
  }
  plugin :render, engine: 'slim'

  route do |r|
    r.root do
      @extracted_ip = extract_remote_ip(r)

      r.env['HTTP_ACCEPT'].split(',').each do |type|
        case type.to_s.chomp
        when 'text/html'
          return view('index')
        when 'text/json', 'application/json'
          return %("#{@extracted_ip}")
        when 'text/plain'
          return @extracted_ip
        end
      end
      response.status = 406
    end
  end

  private

  def extract_remote_ip(r)
    r.ip || r.env['HTTP_X_REAL_IP'] || r.env['REMOTE_ADDR']
  end
end
