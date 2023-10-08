//
//  LocationService.swift
//  WeatherApp
//
//  Created by Liza Kryshkovskaya on 8.10.23.
//

import CoreLocation

protocol LocationService {
    func getCurrentLocation(completion: @escaping (Result<Coordinate, Error>) -> Void)
}
