//  WeatherViewModel.swift
//  Nothing Weather
//
//  Created by mac on 15/03/25.
//
import Foundation

class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherDataModel?
    @Published var forecastData: ForcastDataModel?
    var cityKey: String?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let weatherRepository: WeatherRepository

    init(weatherRepository: WeatherRepository) {
        self.weatherRepository = weatherRepository
    }

    func fetchWeather(cityKey: String) async {
        do {
            let weatherData = try await weatherRepository.fetchWeatherData(for: cityKey)
            DispatchQueue.main.async {
                self.weather = weatherData
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Failed to fetch weather data."
            }
        }
    }

    func fetchForecastData(cityKey: String) async {
        do {
            let forecastData = try await weatherRepository.fetchWeatherForcastData(for: cityKey, for: true, form: true)
            DispatchQueue.main.async {
                self.forecastData = forecastData
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Failed to fetch forecast data."
            }
        }
    }

   
    func fetchLocationKey(lat: Double, long: Double) async {
        DispatchQueue.main.async {
            self.isLoading = true
            self.errorMessage = nil
        }

        do {
            let key = try await weatherRepository.fetchLocationKey(for: lat, lon: long)

        

            // Check if cityKey is nil after setting it
          if !key.isEmpty{
              await fetchWeather(cityKey: key)
              await fetchForecastData(cityKey: key )
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "City key is invalid."
                    self.isLoading = false
                }
            }

            DispatchQueue.main.async {
                self.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Failed to fetch weather data."
                self.isLoading = false
            }
        }
    }

}
