//
//  SearchView.swift
//  WeatherApp
//
//  Created by Liza Kryshkovskaya on 8.10.23.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    viewModel.getWeatherByCurrentLocation()
                } label: {
                    Image(systemName: "location.circle.fill")
                }
                TextField("Search for a city", text: $viewModel.city)
                    .textFieldStyle(.roundedBorder)
                Button {
                    viewModel.clear()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                }
                Button {
                    viewModel.cancel()
                } label: {
                    Text("Cancel")
                }
            }
            
            ForEach(viewModel.locations, id: \.self) { location in
                HStack {
                    Text("\(location.name), \(location.country)")
                        .onTapGesture {
                            viewModel.getWeatherByLocation(Coordinate(lat: location.lat, lon: location.lon))
                        }
                    Spacer()
                }
            }
            
            if let error = viewModel.error {
                Text(error)
            }
        }
        .onChange(of: viewModel.city, perform: { _ in
            viewModel.searchCities()
        })
    }
}
