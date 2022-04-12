require 'spec_helper'

describe 'GET /favicon.ico', type: :request do
  before { get('/favicon.ico') }

  it 'returns 200 HTTP status' do
    expect(last_response.status).to eq 200
  end
end
