//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by Liza Kryshkovskaya on 8.10.23.
//

import SwiftUI

final class SearchViewModel: ObservableObject {
    @Published var city: String = ""
    @Published var locations = [WeatherLocation]()
    @Published var error: String? = nil
    
    private let service: WeatherLocationService
    private let onSelect: (WeatherLocation) -> Void
    private var searchTask: DispatchWorkItem?
    
    init(service: WeatherLocationService, onSelect: @escaping (WeatherLocation) -> Void) {
        self.service = service
        self.onSelect = onSelect
    }
    
    func searchCities() {
        searchTask?.cancel()
        
        guard !city.isEmpty else { return }
        let newSearchTask = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            self.service.getLocationsBy(cityName: self.city) { result in
                switch result {
                case .success(let locations):
                    DispatchQueue.main.async {
                        self.locations = locations
                        print(locations)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.error = error.localizedDescription
                    }
                }
            }
        }
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.3, execute: newSearchTask)
        searchTask = newSearchTask
    }
    
    func getWeatherBy(_ location: WeatherLocation) {
        onSelect(location)
        clear()
    }
    
    func clear() {
        city = ""
        locations = []
    }
}
