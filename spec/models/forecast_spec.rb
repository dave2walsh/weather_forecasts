require 'rails_helper'

RSpec.describe Forecast, type: :model do
  describe "forecast creation" do
    let(:kind) { "current" }
    let(:city) { "Largo" }
    let(:state) { "Tennessee" }
    let(:zip_code) { "34567" }
    let(:address) { Address.create(city: city, state: state, zip_code: zip_code) }
    context "with valid params" do
      let(:forecast) { address.forecasts.build(kind: kind, current_temp: 66, high_temp: 77, low_temp: 55) }
      specify { expect(forecast.valid?).to be true }
    end

    context "with empty kind" do
      let(:forecast) { address.forecasts.build(kind: "", current_temp: 66, high_temp: 77, low_temp: 55) }
      specify { expect(forecast.valid?).to be false }
    end

    context "with 'ten_day' kind: only 'current', 'one_day', 'seven_day' accepted" do
      let(:forecast) { address.forecasts.build(kind: "ten_day", current_temp: 66, high_temp: 77, low_temp: 55) }
      specify { expect(forecast.valid?).to be false }
    end

    context "with 'one_day' and 'seven_day' kinds" do
      let(:forecast_one_day) { address.forecasts.build(kind: "one_day", current_temp: 66, high_temp: 77, low_temp: 55) }
      let(:forecast_seven_day) { address.forecasts.build(kind: "seven_day", current_temp: 66, high_temp: 77, low_temp: 55) }
      specify { expect(forecast_one_day.valid?).to be true }
      specify { expect(forecast_seven_day.valid?).to be true }
    end

    context "with current_temp too high" do
      let(:forecast) { address.forecasts.build(kind: kind, current_temp: 200, high_temp: 77, low_temp: 55) }
      specify { expect(forecast.valid?).to be false }
    end

    context "with current_temp too low" do
      let(:forecast) { address.forecasts.build(kind: kind, current_temp: -101, high_temp: 77, low_temp: 55) }
      specify { expect(forecast.valid?).to be false }
    end

    context "with high_temp too high" do
      let(:forecast) { address.forecasts.build(kind: kind, current_temp: 88, high_temp: 200, low_temp: 55) }
      specify { expect(forecast.valid?).to be false }
    end

    context "with high_temp too low" do
      let(:forecast) { address.forecasts.build(kind: kind, current_temp: 88, high_temp: -101, low_temp: 55) }
      specify { expect(forecast.valid?).to be false }
    end

    context "with low_temp too high" do
      let(:forecast) { address.forecasts.build(kind: kind, current_temp: 88, high_temp: 100, low_temp: 200) }
      specify { expect(forecast.valid?).to be false }
    end

    context "with low_temp too low" do
      let(:forecast) { address.forecasts.build(kind: kind, current_temp: 88, high_temp: 103, low_temp: -101) }
      specify { expect(forecast.valid?).to be false }
    end
  end
end
