//
//  Clouds.swift
//  WeatherApp
//
//  Created by Liza Kryshkovskaya on 10.10.23.
//

struct Clouds: Codable {
    let all: Int
}

extension Clouds: Equatable {
    static func == (lhs: Clouds, rhs: Clouds) -> Bool {
        return lhs.all == rhs.all
    }
}
