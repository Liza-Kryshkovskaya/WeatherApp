//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by Liza Kryshkovskaya on 8.10.23.
//

import SwiftUI

final class SearchViewModel: ObservableObject {
    @Published var city: String = ""
    
    private let service: WeatherLocationService
    private var searchTask: DispatchWorkItem?
    
    init(service: WeatherLocationService) {
        self.service = service
    }
    
    func searchCities() {
        searchTask?.cancel()
        
        guard !city.isEmpty else { return }
        let newSearchTask = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            self.service.getLocationsBy(cityName: self.city) { result in
                switch result {
                case .success(let locations):
                    break
                case .failure(let error):
                    break
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: newSearchTask)
        searchTask = newSearchTask
    }
    
    func getWeatherByCity() {
        if !city.isEmpty {
            print("Search weather in the city = \(city)")
        }
    }
    
    func clear() {
        city = ""
    }
}
