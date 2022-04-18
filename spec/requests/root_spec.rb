require 'spec_helper'

describe 'GET /', type: :request do
  context "browser requests" do
    before { get('/', nil, { 'HTTP_ACCEPT' => 'text/html' }) }

    it 'returns 200 HTTP status' do
      expect(last_response.status).to eq 200
    end

    it 'returns IP in the response body' do
      expect(last_response.body).to include 'YourIP: Check your internet IP address'
    end
  end
end
