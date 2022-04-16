require 'spec_helper'

describe 'GET /', type: :request do
  context "browser requests" do
    before { get('/', nil, { 'HTTP_ACCEPT' => 'text/html' }) }

    it 'returns 200 HTTP status' do
      expect(last_response.status).to eq 200
    end

    it 'returns IP in the response body' do
      expect(last_response.body).to include '127.0.0.1'
    end
  end

  context "json requests" do
    before { get('/', nil, { 'HTTP_ACCEPT' => 'application/json' }) }

    it 'returns 200 HTTP status' do
      expect(last_response.status).to eq 200
    end

    it 'returns IP in the response body' do
      expect(last_response.body).to eq '"127.0.0.1"'
    end
  end

  context "yaml requests" do
    before { get('/', nil, { 'HTTP_ACCEPT' => 'application/x-yaml' }) }

    it 'returns 200 HTTP status' do
      expect(last_response.status).to eq 200
    end

    it 'returns IP in the response body' do
      expect(last_response.body).to eq "--- 127.0.0.1\r\n"
    end
  end

  context "xml requests" do
    before { get('/', nil, { 'HTTP_ACCEPT' => 'application/xml' }) }

    it 'returns 200 HTTP status' do
      expect(last_response.status).to eq 200
    end

    it 'returns IP in the response body' do
      expect(last_response.body).to eq '<ip>127.0.0.1</ip>'
    end
  end

  context "text requests" do
    before { get('/', nil, { 'HTTP_ACCEPT' => 'text/plain' }) }

    it 'returns 200 HTTP status' do
      expect(last_response.status).to eq 200
    end

    it 'returns IP in the response body' do
      expect(last_response.body).to eq '127.0.0.1'
    end
  end

  context "plain requests" do
    before { get('/') }

    it 'returns 200 HTTP status' do
      expect(last_response.status).to eq 200
    end

    it 'returns IP in the response body' do
      expect(last_response.body).to include '127.0.0.1'
    end
  end

  context "svg requests" do
    before { get('/', nil, { 'HTTP_ACCEPT' => 'image/svg+xml' }) }

    it 'returns 200 HTTP status' do
      expect(last_response.status).to eq 200
    end

    it 'returns IP in the response body' do
      expect(last_response.body).to include SVGStatus.new('127.0.0.1').to_svg
    end
  end
end
