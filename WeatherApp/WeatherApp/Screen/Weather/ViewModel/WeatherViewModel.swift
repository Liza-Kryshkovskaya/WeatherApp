//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Liza Kryshkovskaya on 7.10.23.
//

import SwiftUI

final class WeatherViewModel: ObservableObject {
    @Published var city: String = ""
    @Published var temperature: String = ""
    @Published var weatherCondition: String = ""
    @Published var minTemp: String = ""
    @Published var maxTemp: String = ""
    @Published var error: String? = nil
    
    private let service: CurrentWeatherService
    private let locationService: LocationService
    var onSearchTap: (() -> Void)?
    
    init(service: CurrentWeatherService, locationService: LocationService) {
        self.service = service
        self.locationService = locationService
    }
    
    func searchLocation() {
        onSearchTap?()
    }
    
    func getCurrentWeather() {
        locationService.getCurrentLocation { [weak self] result in
            switch result {
            case .success(let coordinate):
                self?.getCurrentWeatherBy(coordinate)
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    self?.error = error.localizedDescription
                }
            }
        }
    }
    
    func getCurrentWeatherBy(_ coordinate: Coordinate) {
        service.getCurrentWeatherBy(coordinate: coordinate) { result in
            switch result {
            case .success(let currentWeather):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.city = currentWeather.city
                    self.temperature = String(currentWeather.main.temp)
                    self.weatherCondition = currentWeather.weatherCondition.first?.description ?? "-"
                    self.minTemp = String(currentWeather.main.minTemp)
                    self.maxTemp = String(currentWeather.main.maxTemp)
                }
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.error = error.localizedDescription
                }
            }
        }
    }
}
