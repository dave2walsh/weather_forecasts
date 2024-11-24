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

    it { should validate_presence_of(:city) }

    it { should validate_presence_of(:state) }

    it { should validate_presence_of(:zip_code) }

    it { should validate_length_of(:city).is_at_least(2).is_at_most(49) }

    it { should validate_length_of(:state).is_at_least(2).is_at_most(49) }

    it { should validate_length_of(:zip_code).is_at_least(5).is_at_most(9) }

    it { should validate_uniqueness_of(:city).scoped_to(:state, :zip_code) }
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
