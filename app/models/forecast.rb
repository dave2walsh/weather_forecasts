class Forecast < ApplicationRecord
  belongs_to :address

  validates :kind, presence: true, inclusion: {in: Rails.configuration.forecast_types_options.values, message: "%{value} is not a valid type"}
  validates :current_temp, :high_temp, :low_temp, numericality: { only_integer: true, in: -100..199 }
end
