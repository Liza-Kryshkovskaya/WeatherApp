//
//  CurrentWeatherMain.swift
//  WeatherApp
//
//  Created by Liza Kryshkovskaya on 7.10.23.
//

import Foundation

struct CurrentWeatherMain: Codable {
    let temp: Double
    let feelsLike: Double
    let minTemp: Double
    let maxTemp: Double
    let pressure: Int
    let humidity: Int

    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
        case pressure, humidity
    }
}

extension CurrentWeatherMain: Equatable {
    static func == (lhs: CurrentWeatherMain, rhs: CurrentWeatherMain) -> Bool {
        return lhs.temp == rhs.temp &&
               lhs.feelsLike == rhs.feelsLike &&
               lhs.minTemp == rhs.minTemp &&
               lhs.maxTemp == rhs.maxTemp &&
               lhs.pressure == rhs.pressure &&
               lhs.humidity == rhs.humidity
    }
}
