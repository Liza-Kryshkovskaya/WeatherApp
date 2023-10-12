//
//  LocationServiceMock.swift
//  WeatherAppTests
//
//  Created by Liza Kryshkovskaya on 12.10.23.
//

@testable import WeatherApp

final class LocationServiceMock: LocationService {
    private var completions = [(Result<WeatherApp.Coordinate, Error>) -> Void]()
    
    func getCurrentLocation(completion: @escaping (Result<WeatherApp.Coordinate, Error>) -> Void) {
        completions.append(completion)
    }
}
