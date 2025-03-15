//
//  WeatherRepositoryImpl.swift
//  Nothing Weather
//
//  Created by mac on 15/03/25.
//


class WeatherRepositoryImpl: WeatherRepository{

    
    var apiKey=""
    
    func fetchWeatherData(for key: String) async throws -> WeatherDataModel {
        let weatherData = try await WeatherManager.getWeatherData(cityKey: key, apiKey: apiKey)
        return weatherData

        
    }
    
    func fetchWeatherForcastData(for key: String, for detail: Bool, form metric: Bool) async throws -> ForcastDataModel {
        let ForcastDataModel=try await WeatherManager.getForecastData(cityKey: key, apiKey: apiKey)
        return ForcastDataModel
    }
    
    func fetchLocationKey(for lat: Double, lon long: Double) async throws -> String {
        let locationKey = try await WeatherManager.getGeoPositionKey(latitude: lat, longitude: long,  apiKey: apiKey)
        return locationKey
    }
    
    
    
}
