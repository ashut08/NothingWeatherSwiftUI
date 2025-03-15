import Foundation

// MARK: - WeatherDataModelElement
struct WeatherDataModelElement: Codable {
    var localObservationDateTime: Date?  // Decode as Date
    var epochTime: Int?
    var weatherText: String?
    var weatherIcon: Int?
    var hasPrecipitation: Bool?
    var precipitationType: JSONNull?
    var isDayTime: Bool?
    var temperature: Temperature?
    var mobileLink, link: String?
    var category: String?  // Dynamically handle category as a string

    enum CodingKeys: String, CodingKey {
        case localObservationDateTime = "LocalObservationDateTime"
        case epochTime = "EpochTime"
        case weatherText = "WeatherText"
        case weatherIcon = "WeatherIcon"
        case hasPrecipitation = "HasPrecipitation"
        case precipitationType = "PrecipitationType"
        case isDayTime = "IsDayTime"
        case temperature = "Temperature"
        case mobileLink = "MobileLink"
        case link = "Link"
        case category = "Category"  // Category field handled dynamically
    }

    // Custom initializer to decode `LocalObservationDateTime` as a String and convert it to Date
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Decode the date string and convert to Date using the custom DateFormatter
        if let dateString = try container.decodeIfPresent(String.self, forKey: .localObservationDateTime) {
            self.localObservationDateTime = DateFormatter.weatherDateFormatter.date(from: dateString)
        }
        
        epochTime = try container.decodeIfPresent(Int.self, forKey: .epochTime)
        weatherText = try container.decodeIfPresent(String.self, forKey: .weatherText)
        weatherIcon = try container.decodeIfPresent(Int.self, forKey: .weatherIcon)
        hasPrecipitation = try container.decodeIfPresent(Bool.self, forKey: .hasPrecipitation)
        precipitationType = try container.decodeIfPresent(JSONNull.self, forKey: .precipitationType)
        isDayTime = try container.decodeIfPresent(Bool.self, forKey: .isDayTime)
        temperature = try container.decodeIfPresent(Temperature.self, forKey: .temperature)
        mobileLink = try container.decodeIfPresent(String.self, forKey: .mobileLink)
        link = try container.decodeIfPresent(String.self, forKey: .link)
        category = try container.decodeIfPresent(String.self, forKey: .category)
    }
}

// MARK: - Temperature
struct Temperature: Codable {
    var metric, imperial: Imperial?

    enum CodingKeys: String, CodingKey {
        case metric = "Metric"
        case imperial = "Imperial"
    }
}

// MARK: - Imperial
struct Imperial: Codable {
    var value: Double?
    var unit: String?
    var unitType: Int?

    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
        case unitType = "UnitType"
    }
}

typealias WeatherDataModel = [WeatherDataModelElement]

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
    }

    public var hashValue: Int {
            return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}

