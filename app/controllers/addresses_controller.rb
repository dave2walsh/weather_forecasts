class AddressesController < ApplicationController
  before_action :set_address, only: [:show]

  def index
    @addresses = Address.all
  end

  def show
  end

  def new
    @address = Address.new
    @address.forecasts.build
    @address.forecasts.build
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to addresses_url, notice: "Address successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def find
  end

  def find_by_zip
  end

  def search
    @address = Address.get_address(city: params[:city], state: params[:state], zip_code: params[:zip_code])
    render :forecasts
  end

  def search_by_zip
    @addresses = Rails.cache.fetch('addresses_by_zip', expires_in: 30.minutes) do
      @cache_miss = true
      Address.get_by_zip(zip_code: params[:zip_code])
    end
    render :zip_forecasts
  end

  private

  def address_params
    params.require(:address).permit(:city, :state, :zip_code, forecasts_attributes: [:kind, :current_temp, :high_temp, :low_temp, :id])
  end

  def set_address
    @address = Address.find(params[:id])
  end
end
