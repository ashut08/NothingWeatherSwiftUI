//
//  WeatherRepository.swift
//  Nothing Weather
//
//  Created by mac on 15/03/25.
//

protocol WeatherRepository {
    func fetchWeatherData(for key: String) async throws -> WeatherDataModel
    func fetchWeatherForcastData(for key: String, for detail:Bool, form metric:Bool) async throws -> ForcastDataModel
    
    func fetchLocationKey(for lat: Double, lon: Double) async throws -> String
    
}
