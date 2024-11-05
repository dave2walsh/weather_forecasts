require 'rails_helper'

RSpec.describe "Addresses", type: :request do
  describe "GET /index" do
    let(:city1) { "Redville" }
    let(:city2) { "Vedville2" }
    let(:city3) { "Qedville3" }
    let(:state) { "California" }
    let(:zip_code1) { "123456" }
    let(:zip_code2) { "45672" }
    let(:zip_code3) { "87547" }
    let!(:address1) { Address.create(city: city1, state: state, zip_code: zip_code1) }
    let!(:address2) { Address.create(city: city2, state: state, zip_code: zip_code2) }
    let!(:address3) { Address.create(city: city3, state: state, zip_code: zip_code3) }
    before do
      get "/addresses"
    end
    it "lists the addresses" do
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(city1)
      expect(response.body).to include(city2)
      expect(response.body).to include(city3)
      expect(response.body).to include(state)
      expect(response.body).to include(zip_code1)
      expect(response.body).to include(zip_code2)
      expect(response.body).to include(zip_code3)
    end
  end

  describe "POST /addresses" do
    let(:city) { "Fargo" }
    let(:state) { "Alaska" }
    let(:zip_code) { "123456" }
    let(:forecasts_params) { {kind: "one_day", current_temp: 66, high_temp: 77, low_temp: 55} }
    let(:address_params) { {address: {city: city, state: state, zip_code: zip_code, forecasts: forecasts_params}} }
    context "with valid params" do
      it "redirects" do
        post "/addresses", params: address_params
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(addresses_url)
      end

      specify do
        expect {
          post "/addresses", params: address_params
        }.to change(Address, :count).by(1)
      end
    end

    context "with blank city" do
      let(:city) { "" }
      before do
        post "/addresses", params: address_params
      end
      it "returns an error" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /addresses/:id" do
    let(:city) { "Redvillez" }
    let(:state) { "Dilifornia" }
    let(:zip_code) { "32541" }
    let(:kind) { "one_day" }
    let(:current_temp) { 88 }
    let(:high_temp) { 96 }
    let(:low_temp) { 63 }
    let!(:address) { Address.create(city: city, state: state, zip_code: zip_code) }
    let!(:forecast) { address.forecasts.create(kind: kind, current_temp: current_temp, high_temp: high_temp, low_temp: low_temp) }
    context "with valid ID" do
      before do
        get "/addresses/#{address.id}"
      end
      it "shows the address" do
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(city)
        expect(response.body).to include(state)
        expect(response.body).to include(zip_code)
        expect(response.body).to include(kind)
        expect(response.body).to include("#{current_temp}")
        expect(response.body).to include("#{high_temp}")
        expect(response.body).to include("#{low_temp}")
      end
    end
    context "with invalid ID" do
      before do
        get "/addresses/badID"
      end
      it "returns an error" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
