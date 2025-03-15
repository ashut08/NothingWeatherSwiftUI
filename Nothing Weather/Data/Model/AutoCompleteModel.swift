// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let autoCompleteModel = try? JSONDecoder().decode(AutoCompleteModel.self, from: jsonData)

import Foundation

// MARK: - AutoCompleteModelElement
struct AutoCompleteModelElement: Codable {
    var version: Int?
    var key, type: String?
    var rank: Int?
    var localizedName: String?
    var country, administrativeArea: AdministrativeArea?

    enum CodingKeys: String, CodingKey {
        case version = "Version"
        case key = "Key"
        case type = "Type"
        case rank = "Rank"
        case localizedName = "LocalizedName"
        case country = "Country"
        case administrativeArea = "AdministrativeArea"
    }
}

// MARK: - AdministrativeArea
struct AdministrativeArea: Codable {
    var id, localizedName: String?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case localizedName = "LocalizedName"
    }
}

typealias AutoCompleteModel = [AutoCompleteModelElement]
