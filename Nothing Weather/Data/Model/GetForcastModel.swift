import Foundation

// Custom DateFormatter for date decoding
extension DateFormatter {
    static let weatherDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // Match the date format from the API
        return formatter
    }()
}

// MARK: - ForcastDataModel
struct ForcastDataModel: Codable {
    var headline: Headline?
    var dailyForecasts: [DailyForecast]?

    enum CodingKeys: String, CodingKey {
        case headline = "Headline"
        case dailyForecasts = "DailyForecasts"
    }

    private static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.weatherDateFormatter)
        return decoder
    }()

    static func decode(from data: Data) throws -> ForcastDataModel {
        return try decoder.decode(ForcastDataModel.self, from: data)
    }
}

struct DailyForecast: Codable {
    var date: Date?
    var epochDate: Int?
    var sun: Sun?
    var moon: Moon?
    var temperature, realFeelTemperature, realFeelTemperatureShade: RealFeelTemperature?
    var hoursOfSun: Double?
    var degreeDaySummary: DegreeDaySummary?
    var airAndPollen: [AirAndPollen]?
    var day, night: Day?
    var sources: [String]?
    var mobileLink, link: String?

    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case epochDate = "EpochDate"
        case sun = "Sun"
        case moon = "Moon"
        case temperature = "Temperature"
        case realFeelTemperature = "RealFeelTemperature"
        case realFeelTemperatureShade = "RealFeelTemperatureShade"
        case hoursOfSun = "HoursOfSun"
        case degreeDaySummary = "DegreeDaySummary"
        case airAndPollen = "AirAndPollen"
        case day = "Day"
        case night = "Night"
        case sources = "Sources"
        case mobileLink = "MobileLink"
        case link = "Link"
    }
}

struct AirAndPollen: Codable {
    var name: String?
    var value: Int?
    var category: String?  // Category as a dynamic String instead of an enum
    var categoryValue: Int?
    var type: String?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case value = "Value"
        case category = "Category"
        case categoryValue = "CategoryValue"
        case type = "Type"
    }
}

struct Day: Codable {
    var icon: Int?
    var iconPhrase: String?
    var hasPrecipitation: Bool?
    var precipitationType, precipitationIntensity, shortPhrase, longPhrase: String?
    var precipitationProbability, thunderstormProbability, rainProbability, snowProbability: Int?
    var iceProbability: Int?
    var wind, windGust: Wind?
    var totalLiquid, rain, snow, ice: Evapotranspiration?
    var hoursOfPrecipitation, hoursOfRain: Double?
    var hoursOfSnow, hoursOfIce, cloudCover: Int?
    var evapotranspiration, solarIrradiance: Evapotranspiration?
    var relativeHumidity: RelativeHumidity?
    var wetBulbTemperature, wetBulbGlobeTemperature: WetBulbTemperature?

    enum CodingKeys: String, CodingKey {
        case icon = "Icon"
        case iconPhrase = "IconPhrase"
        case hasPrecipitation = "HasPrecipitation"
        case precipitationType = "PrecipitationType"
        case precipitationIntensity = "PrecipitationIntensity"
        case shortPhrase = "ShortPhrase"
        case longPhrase = "LongPhrase"
        case precipitationProbability = "PrecipitationProbability"
        case thunderstormProbability = "ThunderstormProbability"
        case rainProbability = "RainProbability"
        case snowProbability = "SnowProbability"
        case iceProbability = "IceProbability"
        case wind = "Wind"
        case windGust = "WindGust"
        case totalLiquid = "TotalLiquid"
        case rain = "Rain"
        case snow = "Snow"
        case ice = "Ice"
        case hoursOfPrecipitation = "HoursOfPrecipitation"
        case hoursOfRain = "HoursOfRain"
        case hoursOfSnow = "HoursOfSnow"
        case hoursOfIce = "HoursOfIce"
        case cloudCover = "CloudCover"
        case evapotranspiration = "Evapotranspiration"
        case solarIrradiance = "SolarIrradiance"
        case relativeHumidity = "RelativeHumidity"
        case wetBulbTemperature = "WetBulbTemperature"
        case wetBulbGlobeTemperature = "WetBulbGlobeTemperature"
    }
}

struct Evapotranspiration: Codable {
    var value: Double?
    var unit: String?  // Unit handled dynamically as a String
    var unitType: Int?
    var phrase: String?  // Phrase handled dynamically as a String

    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
        case unitType = "UnitType"
        case phrase = "Phrase"
    }
}

struct RelativeHumidity: Codable {
    var minimum, maximum, average: Int?

    enum CodingKeys: String, CodingKey {
        case minimum = "Minimum"
        case maximum = "Maximum"
        case average = "Average"
    }
}

struct WetBulbTemperature: Codable {
    var minimum, maximum, average: Evapotranspiration?

    enum CodingKeys: String, CodingKey {
        case minimum = "Minimum"
        case maximum = "Maximum"
        case average = "Average"
    }
}

// MARK: - Wind
struct Wind: Codable {
    var speed: Evapotranspiration?
    var direction: Direction?

    enum CodingKeys: String, CodingKey {
        case speed = "Speed"
        case direction = "Direction"
    }
}

// MARK: - Direction
struct Direction: Codable {
    var degrees: Int?
    var localized, english: String?

    enum CodingKeys: String, CodingKey {
        case degrees = "Degrees"
        case localized = "Localized"
        case english = "English"
    }
}

// MARK: - DegreeDaySummary
struct DegreeDaySummary: Codable {
    var heating, cooling: Evapotranspiration?

    enum CodingKeys: String, CodingKey {
        case heating = "Heating"
        case cooling = "Cooling"
    }
}

// MARK: - Moon
struct Moon: Codable {
    var rise: Date?
    var epochRise: Int?
    var moonSet: Date?
    var epochSet: Int?
    var phase: String?
    var age: Int?

    enum CodingKeys: String, CodingKey {
        case rise = "Rise"
        case epochRise = "EpochRise"
        case moonSet = "Set"
        case epochSet = "EpochSet"
        case phase = "Phase"
        case age = "Age"
    }
}

// MARK: - RealFeelTemperature
struct RealFeelTemperature: Codable {
    var minimum, maximum: Evapotranspiration?

    enum CodingKeys: String, CodingKey {
        case minimum = "Minimum"
        case maximum = "Maximum"
    }
}

// MARK: - Sun
struct Sun: Codable {
    var rise: Date?
    var epochRise: Int?
    var sunSet: Date?
    var epochSet: Int?

    enum CodingKeys: String, CodingKey {
        case rise = "Rise"
        case epochRise = "EpochRise"
        case sunSet = "Set"
        case epochSet = "EpochSet"
    }
}

// MARK: - Headline
struct Headline: Codable {
    var effectiveDate: Date?
    var effectiveEpochDate, severity: Int?
    var text, category: String?  // Category handled dynamically as a String
    var endDate: Date?
    var endEpochDate: Int?
    var mobileLink, link: String?

    enum CodingKeys: String, CodingKey {
        case effectiveDate = "EffectiveDate"
        case effectiveEpochDate = "EffectiveEpochDate"
        case severity = "Severity"
        case text = "Text"
        case category = "Category"
        case endDate = "EndDate"
        case endEpochDate = "EndEpochDate"
        case mobileLink = "MobileLink"
        case link = "Link"
    }
}
