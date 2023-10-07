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
    let city: String
    
    enum CodingKeys: String, CodingKey {
        case weatherCondition = "weather"
        case main
        case city = "name"
    }
}
