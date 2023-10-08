//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Liza Kryshkovskaya on 7.10.23.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.city)
            Text(viewModel.temperature)
            Text(viewModel.weatherCondition)
            Text("H:\(viewModel.maxTemp)")
            Text("L:\(viewModel.minTemp)")
        }
        .onAppear {
            viewModel.getCurrentWeather()
        }
    }
}
