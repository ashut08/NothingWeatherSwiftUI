//
//  LocationServices.swift
//  Nothing Weather
//
//  Created by mac on 15/03/25.
//
import Foundation
class NetworkServices {
    static func fetchData<T: Decodable>(url: URL) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
}
