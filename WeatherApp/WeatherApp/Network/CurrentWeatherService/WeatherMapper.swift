//
//  WeatherMapper.swift
//  WeatherApp
//
//  Created by Liza Kryshkovskaya on 7.10.23.
//

import Foundation

final class WeatherMapper {
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> CurrentWeather {
        let decoder = JSONDecoder()
        
        if response.statusCode == 200 {
            let model = try decoder.decode(CurrentWeather.self, from: data)
            return model
        } else {
            throw NetworkError.invalidData
        }
    }
}
