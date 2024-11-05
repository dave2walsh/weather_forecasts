class Address < ApplicationRecord
  has_many :forecasts

  validates :city, presence: true, length: {in: 2..49}, uniqueness: { scope: [:state, :zip_code] }
  validates :state, presence: true, length: {in: 2..49}
  validates :zip_code, presence: true, length: {in: 5..9}

  def current_forecast
    forecasts.find_by(kind: "current")
  end

  def one_day_forecast
    forecasts.find_by(kind: "one_day")
  end

  def seven_day_forecast
    forecasts.find_by(kind: "seven_day")
  end
end
