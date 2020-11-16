require 'rails_helper'

RSpec.describe 'Shortcodes API', type: :request do
  # initialize test data
  let!(:shortcodes) { create_list(:shortcode, 10) }
  let(:shortcode_id) { shortcode.first.id }

  # Test suite for GET /todos
  describe 'GET /' do
    # make HTTP get request before each example
    before { get '/' }

    it 'returns shortcodes' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /:short_url
  describe 'GET /:short_url' do
    before { get "/shortocdes/#{shortocde_id}" }

    context 'when the record exists' do
      it 'returns the shortocde' do
        expect(json).not_to be_empty
        expect(json['short_url']).to eq(shortocde_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:shortocde_id) { 100 }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find shortocde/)
      end
    end
  end

  # Test suite for POST /shortocdes
  describe 'POST /shortocdes' do
    # valid payload
    let(:valid_attributes) { { original_url: 'https://linkedin.com'} }

    context 'when the request is valid' do
      before { post '/shortocdes', params: valid_attributes }

      it 'creates a shortocde' do
        expect(json['original_url']).to eq('https://linkedin.com')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      before { post '/shortocdes', params: { original_url: 'Foobar' } }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Must be valid URL/)
      end
    end
  end
end