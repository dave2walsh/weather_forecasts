class Forecast < ApplicationRecord
  belongs_to :address

  validates :kind, presence: true, inclusion: {in: %(current, one_day)}
  validates :current_temp, :high_temp, :low_temp, numericality: { only_integer: true, in: -100..199 }
end
