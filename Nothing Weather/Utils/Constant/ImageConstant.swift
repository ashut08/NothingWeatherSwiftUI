//
//  ImageConstant.swift
//  Nothing Weather
//
//  Created by mac on 16/04/25.
//

import SwiftUI

// Weather condition text mapping to SVG path
func getSystemImagePath(text: String, isDayTime: Bool) -> String {
    let dayTimeMappings: [String: String] = [
        "sunny": "sunny",
        "mostly sunny": "sunny",
        "partly sunny": "partly_sunny",
        "clouds and sun": "partly_sunny",
        "some clouds": "partly_sunny",
        "intermittent clouds": "partly_sunny",
        "mostly cloudy": "partly_sunny",
        "hazy sunshine": "hazy_sunshine",
        "cloudy": "cloudy",
        "light rain": "rain",
        "rain": "rain",
        "showers": "rain",
        "thunderstorm": "thunderstorm",
        "thunderstorms": "thunderstorm",
        "mostly cloudy w/ t-storms": "thunderstorm",
        "partly sunny w/ t-storms": "thunderstorm",
        "partly cloudy w/ t-storms": "thunderstorm",
        "snow": "snow",
        "fog": "fog",
        "mostly cloudy w/ snow": "snow",
        "ice": "snow"
    ]
    
    let nightTimeMappings: [String: String] = [
        "clear": "clear",
        "mostly clear": "clear",
        "partly cloudy": "partly_cloudy",
        "some clouds": "partly_cloudy",
        "intermittent clouds": "partly_cloudy",
        "mostly cloudy": "partly_cloudy",
        "hazy moonlight": "hazy_clouds",
        "cloudy": "cloudy",
        "light rain": "rain",
        "rain": "rain",
        "showers": "rain",
        "thunderstorm": "thunderstorm",
        "thunderstorms": "thunderstorm",
        "mostly cloudy w/ t-storms": "thunderstorm",
        "partly sunny w/ t-storms": "thunderstorm",
        "partly cloudy w/ t-storms": "thunderstorm",
        "snow": "snow",
        "fog": "fog",
        "mostly cloudy w/ snow": "snow",
        "ice": "snow"
    ]
    
    let mappings = isDayTime ? dayTimeMappings : nightTimeMappings
    return mappings[text, default: "cloudy"]
}

