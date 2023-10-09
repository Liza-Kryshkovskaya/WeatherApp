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
                TextField("Search for a city", text: $viewModel.city)
                    .textFieldStyle(.roundedBorder)
                Button {
                    viewModel.clear()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                }
            }
            
            ForEach(viewModel.locations, id: \.self) { location in
                Text("\(location.name), \(location.country)")
                    .onTapGesture {
                        viewModel.getWeatherByLocation(Coordinate(lat: location.lat, lon: location.lon))
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
