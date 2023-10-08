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
    var onSearchTap: (() -> Void)?
    
    init(service: CurrentWeatherService) {
        self.service = service
    }
    
    func getCurrentWeather() {
        service.getCurrentWeather { result in
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
    
    func searchLocation() {
        onSearchTap?()
    }
}
