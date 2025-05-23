# frozen_string_literal: true

require 'roda'
require 'digest/sha1'

require_relative "svg_status"

class WhatIsMyIP < Roda
  VERSION = "1.1.0"
  CSS = File.read('assets/style.min.css')
  INDEX_ETAG = Digest::SHA1.hexdigest(File.read('views/index.slim'))
  REVISION = File.exist?('REVISION') ? File.read('REVISION').chomp : 'dev'

  plugin :default_headers, {
    'Application' => 'WhatIsMyIP',
    'Version' => VERSION,
    'Cache-Control' => 'public, max-age=604800'
  }
  plugin :caching
  plugin :public
  plugin :render, engine: 'slim'
  plugin :type_routing, types: { yaml: 'application/x-yaml', txt: 'text/plain', svg: 'image/svg+xml' }

  route do |r|
    r.root do
      r.etag INDEX_ETAG
      @remote_host = r.env['HTTP_HOST']
      view('index')
    end

    r.get(/ip(\.svg|\.txt|\.json|\.yaml|\.xml)?/) do
      response.headers['Cache-Control'] = 'private, max-age=604800, must-revalidate'
      @extracted_ip = extract_remote_ip(r)

      r.etag @extracted_ip

      r.json { %("#{@extracted_ip}") }
      r.svg { SVGStatus.new(@extracted_ip).to_svg }
      r.txt { @extracted_ip }
      r.xml { %(<ip>#{@extracted_ip}</ip>) }
      r.yaml { %(--- #{@extracted_ip}\r\n) }
    end

    r.public
  end

  private

  def extract_remote_ip(r)
    r.ip || r.env['HTTP_X_REAL_IP'] || r.env['REMOTE_ADDR']
  end
end
