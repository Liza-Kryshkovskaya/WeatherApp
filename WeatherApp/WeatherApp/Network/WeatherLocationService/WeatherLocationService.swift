//
//  WeatherLocationService.swift
//  WeatherApp
//
//  Created by Liza Kryshkovskaya on 8.10.23.
//

import Foundation

protocol WeatherLocationService {
    func getLocationsBy(cityName: String, limit: Int, completion: @escaping (Result<[WeatherLocation], Error>) -> Void)
}
