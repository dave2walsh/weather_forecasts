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

  end
end
