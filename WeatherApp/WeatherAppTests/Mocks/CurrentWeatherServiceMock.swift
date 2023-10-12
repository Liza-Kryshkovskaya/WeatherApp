//
//  CurrentWeatherServiceMock.swift
//  WeatherAppTests
//
//  Created by Liza Kryshkovskaya on 12.10.23.
//

@testable import WeatherApp

final class CurrentWeatherServiceMock: CurrentWeatherService {
    private var completions = [(Result<WeatherApp.CurrentWeather, Error>) -> Void]()
    
    func getCurrentWeatherBy(coordinate: WeatherApp.Coordinate, units: String, completion: @escaping (Result<WeatherApp.CurrentWeather, Error>) -> Void) {
        completions.append(completion)
    }
}
