class Address < ApplicationRecord
  has_many :forecasts

  accepts_nested_attributes_for :forecasts

  validates :city, presence: true, length: { in: 2..49 }, uniqueness: { scope: [ :state, :zip_code ] }
  validates :state, presence: true, length: { in: 2..49 }
  # Some US zip codes can be 9 characters long
  validates :zip_code, presence: true, length: { in: 5..9 }

  def self.get_address(city:, state:, zip_code:)
    find_by("lower(city) = ? AND lower(state) = ? AND lower(zip_code) = ?", city.downcase, state.downcase, zip_code.downcase)
  end

  def self.get_by_zip(zip_code:)
    where("lower(zip_code) = ?", zip_code.downcase)
  end

  def current_forecast
    forecasts.find_by(kind: "current")
  end

  def one_day_forecast
    forecasts.find_by(kind: "one_day")
  end

  def max_temp
    forecasts.maximum(:high_temp)
  end

  def min_temp
    forecasts.minimum(:low_temp)
  end
end
