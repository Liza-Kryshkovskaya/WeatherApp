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

                        if let weather = viewModel.weather {
                            VStack {
                                Text(weather.city)
                                Text(weather.temperature)
                                Image(systemName: weather.weatherIconName)
                                Text(weather.weatherCondition)
                                HStack {
                                    Text("H:" + weather.maxTemp)
                                    Text("L:" + weather.minTemp)
                                }
                            }
                            Text("Visibility " + weather.visibility)
                            Text("Wind " + weather.windSpeed)
                            Text("Sunset " + weather.sunset)
                            Text("Sunrise " + weather.sunrise)
                            Text("Pressure " + weather.pressure)
                            Text("Humidity " + weather.humidity)
                            Text("Cloudiness " + weather.clouds)
                            Text("Feels like " + weather.feelsLike)
                        }
                        
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
