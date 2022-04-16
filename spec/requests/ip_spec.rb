require 'spec_helper'

describe 'GET /ip', type: :request do
  context "ip.svg" do
    before { get('/ip.svg') }

    it 'returns 200 HTTP status' do
      expect(last_response.status).to eq 200
    end

    it 'returns the SVG in the response body' do
      expect(last_response.body).to include SVGStatus.new('127.0.0.1').to_svg
    end
  end
end
