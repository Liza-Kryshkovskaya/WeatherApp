//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by Liza Kryshkovskaya on 8.10.23.
//

import SwiftUI

final class SearchViewModel: ObservableObject {
    @Published var city: String = ""
    
    private var searchTask: DispatchWorkItem?
    
    func searchCities() {
        searchTask?.cancel()
        
        guard !city.isEmpty else { return }
        let newSearchTask = DispatchWorkItem { print("Super") }
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
