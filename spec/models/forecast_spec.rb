require 'rails_helper'

RSpec.describe Forecast, type: :model do
  describe "forecast creation" do
    let(:kind) { "current" }
    let(:city) { "Largo" }
    let(:state) { "Tennessee" }
    let(:zip_code) { "34567" }
    let(:address) { Address.create(city: city, state: state, zip_code: zip_code) }

    subject { address.forecasts.build(kind: kind, current_temp: 66, high_temp: 77, low_temp: 55) }

    context "with valid params" do
      let(:forecast) { address.forecasts.build(kind: kind, current_temp: 66, high_temp: 77, low_temp: 55) }
      specify { expect(forecast.valid?).to be true }
    end

    it { should validate_inclusion_of(:kind).in_array(%w[current, one_day]) }

    it { should validate_numericality_of(:current_temp).is_in(-100..199).only_integer }

    it { should validate_numericality_of(:high_temp).is_in(-100..199).only_integer }

    it { should validate_numericality_of(:low_temp).is_in(-100..199).only_integer }
  end
end
