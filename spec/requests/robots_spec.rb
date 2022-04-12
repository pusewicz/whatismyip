require 'spec_helper'

describe 'GET /robots.txt', type: :request do
  before { get('/robots.txt') }

  it 'returns 200 HTTP status' do
    expect(last_response.status).to eq 200
  end

  it 'allows all crawlers' do
    expect(last_response.body).to eq "User-agent: *\nAllow: /\n"
  end

  it 'uses text content type' do
    expect(last_response.headers['Content-Type']).to eq 'text/plain'
  end
end
