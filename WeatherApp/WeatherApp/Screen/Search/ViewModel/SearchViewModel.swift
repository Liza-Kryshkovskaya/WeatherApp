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
    @Published var showLocationErrorAlert: Bool = false
    
    private let service: WeatherLocationService
    private let locationService: LocationService
    private let onSelect: (Coordinate) -> Void
    private let onCancelButtonTap: () -> Void
    private var searchTask: DispatchWorkItem?
    
    init(service: WeatherLocationService,
         locationService: LocationService,
         onSelect: @escaping (Coordinate) -> Void,
         onCancelButtonTap: @escaping () -> Void) {
        self.service = service
        self.locationService = locationService
        self.onSelect = onSelect
        self.onCancelButtonTap = onCancelButtonTap
    }
    
    func searchCities() {
        searchTask?.cancel()
        
        guard !city.isEmpty else { return }
        let newSearchTask = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            self.service.getLocationsBy(cityName: self.city, limit: Constants.limit) { result in
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
    
    func getWeatherByCurrentLocation() {
        locationService.getCurrentLocation { [weak self] result in
            switch result {
            case .success(let coordinate):
                self?.onSelect(coordinate)
            case .failure:
                self?.showLocationErrorAlert = true
            }
        }
        
        clear()
    }
    
    func clear() {
        city = ""
        locations = []
        error = nil
    }
    
    func cancel() {
        onCancelButtonTap()
    }
}
