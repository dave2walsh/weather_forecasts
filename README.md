# README

This application does the following:

* Saves addresses along with their associated forecasts

* The addresses include the city, state and zip code

* Each address has associated forecasts

* Each forecast can either be the current forecast or the forecast one day into the future

* Each forecast has the kind of forecast, the current temperature, the maximum temperature and the minimum temperature

* Allows searching for an address

* Displays the address along with its forecasts

* Allows searching for addresses based on zip codes

* These zip code searches are cached for 30 minutes

* The zip code search results page show whether or not the results are pulled from the cache

* Allows searches by addresses

* Retrieves forecast data for a given address, which includes the current temperature,

# Things that need improvement if time allowed

* Do not allow a current temperature to be saved for one_day forecasts

* Should not allow two of the same kinds of forecasts to be associated to the same address

* For each forecast, saving a low temperature that's higher than the high temperature should not be allowed

* Needs more model, such as tests for Address.get_address and Address.get_by_zip 

* Needs requests tests for AddressesController#find, AddressesController#find_by_zip, AddressesController#search and AddressesController#search_by_zip

* Better UI

# Assumptions

* Only a small number of addresses will be saved, as addresses#index grabs all the addresses

* Temperatures are in Fahrenheit

# How to run

* bundle

* rails db:migrate

* rails dev:cache to turn on caching in development 

* rails s

* ...
