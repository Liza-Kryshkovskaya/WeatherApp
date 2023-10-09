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
    @Published var units: Units = .metric
    private var selectedCoordinate: Coordinate = Constants.defaultCoordinate
    private let service: CurrentWeatherService
    private let locationService: LocationService
    var onSearchTap: (() -> Void)?
    
    init(service: CurrentWeatherService, locationService: LocationService) {
        self.service = service
        self.locationService = locationService
        
        getCurrentWeather()
    }
    
    func searchLocation() {
        onSearchTap?()
    }
    
    func toggleUnits() {
        units = units == .metric ? .imperial : .metric
        getCurrentWeatherBy(selectedCoordinate)
    }
    
    func retry() {
        error = nil
        getCurrentWeather()
    }
    
    func getCurrentWeatherBy(_ coordinate: Coordinate) {
        service.getCurrentWeatherBy(coordinate: coordinate, units: units.rawValue) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let currentWeather):
                    self.city = currentWeather.city
                    self.temperature = String(currentWeather.main.temp)
                    self.weatherCondition = currentWeather.weatherCondition.first?.description ?? "-"
                    self.minTemp = String(currentWeather.main.minTemp)
                    self.maxTemp = String(currentWeather.main.maxTemp)
                    self.selectedCoordinate = coordinate
                case .failure(let error):
                    self.error = error.localizedDescription
                }
            }
        }
    }
    
    private func getCurrentWeather() {
        locationService.getCurrentLocation { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let coordinate):
                self.getCurrentWeatherBy(coordinate)
            case .failure:
                self.getCurrentWeatherBy(self.selectedCoordinate)
            }
        }
    }
}
