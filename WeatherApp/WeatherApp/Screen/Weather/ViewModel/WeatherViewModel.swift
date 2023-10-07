//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Liza Kryshkovskaya on 7.10.23.
//

import SwiftUI

final class WeatherViewModel: ObservableObject {
    private let service: CurrentWeatherService
    
    init(service: CurrentWeatherService) {
        self.service = service
    }
    
    func getCurrentWeather() {
        service.getCurrentWeather { result in
            switch result {
            case .success(let currentWeather):
                break
            case .failure(let error):
                break
            }
        }
    }
}
