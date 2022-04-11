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
end
