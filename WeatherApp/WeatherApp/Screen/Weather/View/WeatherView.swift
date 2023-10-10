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
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .loaded(let error):
                if let error = error {
                    Button(action: {
                        viewModel.retry()
                    }) {
                        Text("\(error) Retry")
                    }
                } else {
                    VStack {
                        Button {
                            viewModel.searchLocation()
                        } label: {
                            Image(systemName: "magnifyingglass")
                        }

                        Text(viewModel.city)
                        Text(viewModel.temperature)
                        Text(viewModel.weatherCondition)
                        Text("H:\(viewModel.maxTemp)")
                        Text("L:\(viewModel.minTemp)")
                        
                        Button {
                            viewModel.toggleUnits()
                        } label: {
                            Text(viewModel.units == .metric ? "C" : "F")
                        }

                    }
                }
            }
        }
    }
}
