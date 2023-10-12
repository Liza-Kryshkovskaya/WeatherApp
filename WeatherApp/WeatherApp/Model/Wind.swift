//
//  Wind.swift
//  WeatherApp
//
//  Created by Liza Kryshkovskaya on 10.10.23.
//

struct Wind: Codable {
    let speed: Double
}

extension Wind: Equatable {
    static func == (lhs: Wind, rhs: Wind) -> Bool {
        return lhs.speed == rhs.speed
    }
}
