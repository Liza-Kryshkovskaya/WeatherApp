//
//  WeatherLocation.swift
//  WeatherApp
//
//  Created by Liza Kryshkovskaya on 8.10.23.
//

import Foundation

struct WeatherLocation: Codable {
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String?
}
