//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Liza Kryshkovskaya on 7.10.23.
//

import Foundation

struct CurrentWeather: Codable {
    let weatherCondition: [WeatherCondition]
    let main: CurrentWeatherMain
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let sun: Sun
    let city: String
    let timezone: Int
    
    enum CodingKeys: String, CodingKey {
        case weatherCondition = "weather"
        case main
        case visibility, wind, clouds
        case sun = "sys"
        case city = "name"
        case timezone
    }
}
