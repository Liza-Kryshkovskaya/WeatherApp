//
//  CurrentWeatherService.swift
//  WeatherApp
//
//  Created by Liza Kryshkovskaya on 7.10.23.
//

import Foundation

protocol CurrentWeatherService {
    func getCurrentWeatherBy(coordinate: Coordinate, completion: @escaping (Result<CurrentWeather, Error>) -> Void)
}
