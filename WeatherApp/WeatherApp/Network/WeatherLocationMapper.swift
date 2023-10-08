//
//  WeatherLocationMapper.swift
//  WeatherApp
//
//  Created by Liza Kryshkovskaya on 8.10.23.
//

import Foundation

final class WeatherLocationMapper {
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [WeatherLocation] {
        let decoder = JSONDecoder()
        
        if response.statusCode == 200 {
            let model = try decoder.decode([WeatherLocation].self, from: data)
            return model
        } else {
            throw NetworkError.invalidData
        }
    }
}
