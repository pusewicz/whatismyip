require 'spec_helper'

describe 'GET /sitemap.xml', type: :request do
  before { get('/sitemap.xml') }

  it 'returns 200 HTTP status' do
    expect(last_response.status).to eq 200
  end

  it 'allows all crawlers' do
    expect(last_response.body).to eq <<~XML
      <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">
        <url>
          <loc>https://yourip.herokuapp.com.com/</loc>
          <lastmod>#{File.mtime('lib/whatismyip.rb').strftime("%F")}</lastmod>
          <changefreq>weekly</changefreq>
          <priority>1</priority>
        </url>
      </urlset>
    XML
  end

  it 'uses text content type' do
    expect(last_response.headers['Content-Type']).to eq 'application/xml'
  end
end
