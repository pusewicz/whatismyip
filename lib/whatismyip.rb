# frozen_string_literal: true

require 'roda'
require_relative "svg_status"

class WhatIsMyIP < Roda
  VERSION = "1.1.0"

  plugin :default_headers, {
    'Application' => self.class.name,
    'Version' => VERSION,
    'Cache-Control' => 'no-store, max-age=0'
  }
  plugin :public
  plugin :render, engine: 'slim'
  plugin :type_routing, types: { yaml: 'application/x-yaml', text: 'text/plain', svg: 'image/svg+xml' }

  route do |r|
    r.root do
      @extracted_ip = extract_remote_ip(r)

      r.html { view('index') }
      r.json { %("#{@extracted_ip}") }
      r.svg { SVGStatus.new(@extracted_ip).to_svg }
      r.text { @extracted_ip }
      r.xml { %(<ip>#{@extracted_ip}</ip>) }
      r.yaml { %(--- #{@extracted_ip}\r\n) }
    end

    r.get('sitemap') do
      response['Content-Type'] = 'application/xml'

      <<~SITEMAP
        <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">
          <url>
            <loc>https://yourip.herokuapp.com.com/</loc>
            <lastmod>#{File.mtime(__FILE__).strftime("%F")}</lastmod>
            <changefreq>weekly</changefreq>
            <priority>1</priority>
          </url>
        </urlset>
      SITEMAP
    end

    r.public
  end

  private

  def extract_remote_ip(r)
    r.ip || r.env['HTTP_X_REAL_IP'] || r.env['REMOTE_ADDR']
  end
end
