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
        HStack {
            TextField("Search for a city", text: $viewModel.city) {
                viewModel.getWeatherByCity()
            }
            .textFieldStyle(.roundedBorder)
            Button {
                viewModel.clear()
            } label: {
                Image(systemName: "xmark.circle.fill")
            }
        }

    }
}
