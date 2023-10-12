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
    
    func complete(with error: Error, at index: Int = 0) {
        completions[index](.failure(error))
    }
    
    func complete(with coordinate: WeatherApp.Coordinate, at index: Int = 0) {
        completions[index](.success(coordinate))
    }
}
