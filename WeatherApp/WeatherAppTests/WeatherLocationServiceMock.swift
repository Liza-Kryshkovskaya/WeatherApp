//
//  WeatherLocationServiceMock.swift
//  WeatherAppTests
//
//  Created by Liza Kryshkovskaya on 12.10.23.
//

@testable import WeatherApp

final class WeatherLocationServiceMock: WeatherLocationService {
    var completions = [(Result<[WeatherApp.WeatherLocation], Error>) -> Void]()
    
    func getLocationsBy(cityName: String, limit: Int, completion: @escaping (Result<[WeatherApp.WeatherLocation], Error>) -> Void) {
        completions.append(completion)
    }
}
