require 'rails_helper'

RSpec.describe Address, type: :model do
  describe "address creation" do
    context "with valid params" do
      let(:city) { "Redville" }
      let(:state) { "California" }
      let(:zip_code) { "123456" }
      let(:address) { Address.new(city: city, state: state, zip_code: zip_code) }
      specify { expect(address.valid?).to be true }
    end

    context "with no city" do
      let(:state) { "California" }
      let(:zip_code) { "123456" }
      let(:address) { Address.new(state: state, zip_code: zip_code) }
      specify { expect(address.valid?).to be false }
    end

    context "with no state" do
      let(:city) { "Redville" }
      let(:zip_code) { "123456" }
      let(:address) { Address.new(city: city, zip_code: zip_code) }
      specify { expect(address.valid?).to be false }
    end

    context "with no zip_code" do
      let(:city) { "Redville" }
      let(:state) { "California" }
      let(:address) { Address.new(city: city, state: state) }
      specify { expect(address.valid?).to be false }
    end

    context "with city too long" do
      let(:city) { "Redvillelal"*5 }
      let(:state) { "California" }
      let(:zip_code) { "123456" }
      let(:address) { Address.new(city: city, state: state, zip_code: zip_code) }
      specify { expect(address.valid?).to be false }
    end

    context "with city too short" do
      let(:city) { "R" }
      let(:state) { "California" }
      let(:zip_code) { "123456" }
      let(:address) { Address.new(city: city, state: state, zip_code: zip_code) }
      specify { expect(address.valid?).to be false }
    end

    context "with state too long" do
      let(:city) { "Redvillelal" }
      let(:state) { "Californias"*5 }
      let(:zip_code) { "123456" }
      let(:address) { Address.new(city: city, state: state, zip_code: zip_code) }
      specify { expect(address.valid?).to be false }
    end

    context "with state too short" do
      let(:city) { "Redvillelal" }
      let(:state) { "C" }
      let(:zip_code) { "123456" }
      let(:address) { Address.new(city: city, state: state, zip_code: zip_code) }
      specify { expect(address.valid?).to be false }
    end

    context "with zip_code too long" do
      let(:city) { "Redvillelal" }
      let(:state) { "Californias" }
      let(:zip_code) { "1234567890" }
      let(:address) { Address.new(city: city, state: state, zip_code: zip_code) }
      specify { expect(address.valid?).to be false }
    end

    context "with state too short" do
      let(:city) { "Redvillelal" }
      let(:state) { "California" }
      let(:zip_code) { "1234" }
      let(:address) { Address.new(city: city, state: state, zip_code: zip_code) }
      specify { expect(address.valid?).to be false }
    end

    context "with repeated address" do
      let(:city) { "Redvillelal" }
      let(:state) { "California" }
      let(:zip_code) { "12348" }
      let!(:address1) { Address.create(city: city, state: state, zip_code: zip_code) }
      let(:address2) { Address.build(city: city, state: state, zip_code: zip_code) }
      specify { expect(address2.valid?).to be false }
    end

    context "with repeated city and state" do
      let(:city) { "Redvillelal" }
      let(:state) { "California" }
      let(:zip_code) { "12348" }
      let!(:address1) { Address.create(city: city, state: state, zip_code: zip_code) }
      let(:address2) { Address.build(city: city, state: state, zip_code: "98765") }
      specify { expect(address2.valid?).to be true }
    end
  end

  describe "getting the forecasts for an address" do
    let(:kind) { "current" }
    let(:city) { "Largo" }
    let(:state) { "Tennessee" }
    let(:zip_code) { "34567" }
    let(:current_temp) { 70 }
    let(:high_temp) { 88 }
    let(:low_temp) { 68 }
    let!(:address) { Address.create(city: city, state: state, zip_code: zip_code) }

    context "current forecast" do
      let!(:forecast) { address.forecasts.create(kind: kind, current_temp: current_temp, high_temp: high_temp, low_temp: low_temp) }
      it "returns the current forecast" do
        current_forecast = address.current_forecast
        expect(current_forecast.current_temp).to eq(current_temp)
        expect(current_forecast.high_temp).to eq(high_temp)
        expect(current_forecast.low_temp).to eq(low_temp)
      end
    end

    context "one_day forecast" do
      let(:kind) { "one_day" }
      let(:high_temp) { 102 }
      let(:low_temp) { 75 }
      let!(:forecast) { address.forecasts.create(kind: kind, current_temp: current_temp, high_temp: high_temp, low_temp: low_temp) }
      it "returns the one_day forecast" do
        one_day_forecast = address.one_day_forecast
        expect(one_day_forecast.current_temp).to eq(current_temp)
        expect(one_day_forecast.high_temp).to eq(high_temp)
        expect(one_day_forecast.low_temp).to eq(low_temp)
      end
    end
  end
end
