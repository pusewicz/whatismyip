# frozen_string_literal: true

require 'roda'

class WhatIsMyIP < Roda
  VERSION = "1.1.0"

  plugin :default_headers, {
    'Application' => self.class.name,
    'Version' => VERSION,
    'Cache-Control' => 'no-store, max-age=0'
  }
  plugin :render, engine: 'slim'
  plugin :type_routing, types: { yaml: 'application/x-yaml', text: 'text/plain' }

  route do |r|
    r.root do
      @extracted_ip = extract_remote_ip(r)

      r.json { %("#{@extracted_ip}") }
      r.yaml { %(--- #{@extracted_ip}\r\n) }
      r.xml { %(<ip>#{@extracted_ip}</ip>) }
      r.text { @extracted_ip }
      r.html { view('index') }
    end

    r.get('robots.txt') do
      response['Content-Type'] = 'text/plain'
      "User-agent: *\r\nAllow: /"
    end

    r.get('sitemap') do
      response['Content-Type'] = 'application/xml'

      <<~SITEMAP
        <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">
          <url>
            <loc>http://yourip.herokuapp.com.com/</loc>
            <lastmod>#{File.mtime(__FILE__).strftime("%F")}</lastmod>
            <changefreq>weekly</changefreq>
            <priority>1</priority>
          </url>
        </urlset>
      SITEMAP
    end
  end

  private

  def extract_remote_ip(r)
    r.ip || r.env['HTTP_X_REAL_IP'] || r.env['REMOTE_ADDR']
  end
end
