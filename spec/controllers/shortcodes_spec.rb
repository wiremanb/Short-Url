require 'rails_helper'

RSpec.describe ShortcodesController, type: :controller do

  let(:parsed_response) { JSON.parse(response.body) }

  describe "index" do
    let!(:short_url) { Shortcode.create(original_url: "https://www.test.com", short_url: 'zx', popularity: 1) }
    let(:public_attributes) do
      {
        "original_url" => short_url.original_url,
        "short_url"    => short_url.short_url,
        "popularity"   => short_url.popularity,
      }
    end

    it "is a successful response" do
      get :index, format: :json
      expect(response.status).to eq 200
    end

    it "has a list of the top 100 urls" do
      get :index
      expect(parsed_response[0]).to include(public_attributes)
    end
  end

  describe "create" do

    it "creates a short_url" do
      post :create, params: { original_url: "https://www.test.com" }, format: :json
      expect(parsed_response['short_url']).to be_a(String)
    end

    it "does not create a short_url" do
      post :create, params: { original_url: "nope!" }, format: :json
      expect(parsed_response['errors']).to be_include("Original url Valid URLs only")
    end

  end

  describe "goto" do
    let!(:shortcode) { Shortcode.create(id: 5, original_url: "http://test.host", short_url: "123", popularity: 1) }

    it "redirects to the short_url" do
      get :goto, params: { short_url: shortcode.short_url }
      expect(response).to redirect_to(shortcode.original_url)
    end

    it "does not redirect to the short_url" do
      get :goto, params: { short_url: "nope" }
      expect(response.status).to eq(404)
    end

    it "increments the popularity for the url" do
      expect { get :goto, params: { short_url: shortcode.short_url } }.to change { Shortcode.find(shortcode.id).popularity }.by(1)
    end

  end

end
