require 'spec_helper'

describe 'GET /ip', type: :request do
  context "ip.svg" do
    before { get('/ip.svg') }

    it 'returns 200 HTTP status' do
      expect(last_response.status).to eq 200
    end

    it 'sets cache control to private' do
      expect(last_response.headers['Cache-Control']).to eq "private, max-age=604800, must-revalidate"
    end

    it 'returns the SVG in the response body' do
      expect(last_response.body).to include SVGStatus.new('127.0.0.1').to_svg
    end
  end

  context "json requests" do
    before { get('/ip.json') }

    it 'returns 200 HTTP status' do
      expect(last_response.status).to eq 200
    end

    it 'sets cache control to private' do
      expect(last_response.headers['Cache-Control']).to eq "private, max-age=604800, must-revalidate"
    end

    it 'returns IP in the response body' do
      expect(last_response.body).to eq '"127.0.0.1"'
    end
  end

  context "yaml requests" do
    before { get('/ip.yaml') }

    it 'returns 200 HTTP status' do
      expect(last_response.status).to eq 200
    end

    it 'sets cache control to private' do
      expect(last_response.headers['Cache-Control']).to eq "private, max-age=604800, must-revalidate"
    end

    it 'returns IP in the response body' do
      expect(last_response.body).to eq "--- 127.0.0.1\r\n"
    end
  end

  context "xml requests" do
    before { get('/ip.xml') }

    it 'returns 200 HTTP status' do
      expect(last_response.status).to eq 200
    end

    it 'sets cache control to private' do
      expect(last_response.headers['Cache-Control']).to eq "private, max-age=604800, must-revalidate"
    end

    it 'returns IP in the response body' do
      expect(last_response.body).to eq '<ip>127.0.0.1</ip>'
    end
  end

  context "text requests" do
    before { get('/ip.txt') }

    it 'returns 200 HTTP status' do
      expect(last_response.status).to eq 200
    end

    it 'sets cache control to private' do
      expect(last_response.headers['Cache-Control']).to eq "private, max-age=604800, must-revalidate"
    end

    it 'returns IP in the response body' do
      expect(last_response.body).to eq '127.0.0.1'
    end
  end
end
