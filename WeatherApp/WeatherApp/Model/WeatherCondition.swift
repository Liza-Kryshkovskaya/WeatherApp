//
//  WeatherCondition.swift
//  WeatherApp
//
//  Created by Liza Kryshkovskaya on 7.10.23.
//

import Foundation

struct WeatherCondition: Codable {
    let main: String
    let description: String
    let icon: String
}
