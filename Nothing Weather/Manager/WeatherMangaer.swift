import Foundation

enum WeatherManagerError: Error {
    case locationNotFound
    case noDataAvailable
    case keyNotFound
    case jsonParsingError
}

class WeatherManager {
    static let baseUrl = "https://dataservice.accuweather.com"
    
    static func getLocation(query: String, apiKey: String) async throws -> AutoCompleteModelElement {
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = URL(string: "\(baseUrl)/locations/v1/cities/autocomplete?q=\(query)&apikey=\(apiKey)")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Print API response as a string
        if let responseString = String(data: data, encoding: .utf8) {
            print("API Response: \(responseString)")
        }
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw WeatherManagerError.locationNotFound
        }
        
        let locationJson = try JSONDecoder().decode(AutoCompleteModelElement.self, from: data)
        return locationJson
    }
    
    static func getWeatherData(cityKey: String, apiKey: String) async throws -> WeatherDataModel {
        let url = URL(string: "\(baseUrl)/currentconditions/v1/\(cityKey)?apikey=\(apiKey)&details=true")!
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Print API response as a string
        if let responseString = String(data: data, encoding: .utf8) {
            print("API Response: \(responseString)")
        }
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw WeatherManagerError.noDataAvailable
        }
        do {
            let weatherJson = try JSONDecoder().decode(WeatherDataModel.self, from: data)
            return weatherJson
        } catch let error {
            print("Decoding error: \(error)")
            // Optionally: Print the raw data to inspect
            if let responseString = String(data: data, encoding: .utf8) {
                print("Raw JSON: \(responseString)")
            }
            throw error // Rethrow the error if needed
        }
      
    }
    
    static func getForecastData(cityKey: String, apiKey: String) async throws -> ForcastDataModel {
        let url = URL(string: "\(baseUrl)/forecasts/v1/daily/5day/\(cityKey)?apikey=\(apiKey)&details=true&metric=true")!
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Print API response as a string
        if let responseString = String(data: data, encoding: .utf8) {
            print("API Response: \(responseString)")
        }
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw WeatherManagerError.noDataAvailable
        }
        do {
            let forecastJson = try ForcastDataModel.decode(from: data)
            // Successfully parsed
            return forecastJson
        } catch let error {
            print("Decoding error: \(error)")
            // Optionally: Print the raw data to inspect
            if let responseString = String(data: data, encoding: .utf8) {
                print("Raw JSON: \(responseString)")
            }
            throw error // Rethrow the error if needed
        }
 
    }
    
    static func getGeoPositionKey(latitude: Double, longitude: Double, apiKey: String) async throws -> String {
        let url = URL(string: "\(baseUrl)/locations/v1/cities/geoposition/search?q=\(latitude),\(longitude)&apikey=\(apiKey)")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Print API response as a string
        if let responseString = String(data: data, encoding: .utf8) {
            print("API Response: \(responseString)")
        }
        
        // Ensure the response status code is 200 (OK)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw WeatherManagerError.noDataAvailable
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            
            // Access the "Key" field from the response
            if let key = json?["Key"] as? String {
                return key
            } else {
                throw WeatherManagerError.keyNotFound
            }
        } catch {
            throw WeatherManagerError.jsonParsingError
        }
    }
}
