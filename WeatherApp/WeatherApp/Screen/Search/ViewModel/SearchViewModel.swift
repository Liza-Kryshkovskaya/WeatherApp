//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by Liza Kryshkovskaya on 8.10.23.
//

import SwiftUI

final class SearchViewModel: ObservableObject {
    @Published var city: String = ""
    
    func getWeatherByCity() {
        if !city.isEmpty {
            print("Search weather in the city = \(city)")
        }
    }
    
    func clear() {
        city = ""
    }
}
