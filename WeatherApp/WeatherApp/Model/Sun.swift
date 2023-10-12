//
//  Sun.swift
//  WeatherApp
//
//  Created by Liza Kryshkovskaya on 10.10.23.
//

struct Sun: Codable {
    let sunrise: Int
    let sunset: Int
}

extension Sun: Equatable {
    static func == (lhs: Sun, rhs: Sun) -> Bool {
        return lhs.sunrise == rhs.sunrise && lhs.sunset == rhs.sunset
    }
}
