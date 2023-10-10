//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Liza Kryshkovskaya on 7.10.23.
//

import SwiftUI

final class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherDisplayModel?
    @Published var units: Units = .metric
    @Published var state: State = .loading
    private var selectedCoordinate: Coordinate = Constants.defaultCoordinate
    private let weatherService: CurrentWeatherService
    private let locationService: LocationService
    var onSearchTap: (() -> Void)?
    
    init(weatherService: CurrentWeatherService, locationService: LocationService) {
        self.weatherService = weatherService
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
        state = .loading
        getCurrentWeather()
    }
    
    func getCurrentWeatherBy(_ coordinate: Coordinate) {
        state = .loading
        weatherService.getCurrentWeatherBy(coordinate: coordinate, units: units.rawValue) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let currentWeather):
                    self.weather = WeatherDisplayModel(from: currentWeather)
                    self.selectedCoordinate = coordinate
                    self.state = .loaded(error: nil)
                case .failure(let error):
                    self.state = .loaded(error: error.localizedDescription)
                }
            }
        }
    }
    
    private func getCurrentWeather() {
        state = .loading
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
