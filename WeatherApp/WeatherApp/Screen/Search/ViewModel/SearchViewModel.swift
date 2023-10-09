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
    private let onSelect: (Coordinate) -> Void
    private var searchTask: DispatchWorkItem?
    
    init(service: WeatherLocationService, onSelect: @escaping (Coordinate) -> Void) {
        self.service = service
        self.onSelect = onSelect
    }
    
    func searchCities() {
        searchTask?.cancel()
        
        guard !city.isEmpty else { return }
        let newSearchTask = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            self.service.getLocationsBy(cityName: self.city) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let locations):
                        self.locations = locations
                    case .failure(let error):
                        self.error = error.localizedDescription
                    }
                }
            }
        }
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.3, execute: newSearchTask)
        searchTask = newSearchTask
    }
    
    func getWeatherByLocation(_ coordinate: Coordinate) {
        onSelect(coordinate)
        clear()
    }
    
    func clear() {
        city = ""
        locations = []
    }
}
