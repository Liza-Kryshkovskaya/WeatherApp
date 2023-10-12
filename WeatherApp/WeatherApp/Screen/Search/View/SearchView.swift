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
        ZStack {
            WeatherBackround()
            VStack {
                HStack {
                    locationButton
                    searchField
                    cancelButton
                }
                .padding(.horizontal, 16)
                if !viewModel.locations.isEmpty {
                    content
                }
                Spacer()
                
                if let error = viewModel.error {
                    ErrorView(error: error, action: nil)
                }
                Spacer()
            }
        }
        .alert(isPresented: $viewModel.showLocationErrorAlert) { locationAlert }
        .onChange(of: viewModel.city, perform: ({ _ in
            viewModel.searchCities()
        }))
    }
    
    private var locationButton: some View {
        Button {
            viewModel.getWeatherByCurrentLocation()
        } label: {
            Image(systemName: "location.circle")
                .foregroundColor(WeatherViewConstants.foregroundColor)
                .font(.system(size: 24))
        }
    }
    
    private var searchField: some View {
        ZStack(alignment: .trailing) {
            TextField("Search for a city", text: $viewModel.city)
                .textFieldStyle(.roundedBorder)
                .opacity(0.4)
            if !viewModel.city.isEmpty {
                Button {
                    withAnimation {
                        viewModel.clear()
                    }
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(WeatherViewConstants.foregroundColor)
                }
                .padding(.trailing, 4)
            }
        }
    }
    
    private var cancelButton: some View {
        Button { viewModel.cancel() } label: {
            Text("Cancel")
                .foregroundColor(WeatherViewConstants.foregroundColor)
                .fontWeight(.semibold)
        }
    }

    private var content: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ForEach(viewModel.locations, id: \.self) { location in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(location.name + ", " + location.country)
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        .foregroundColor(WeatherViewConstants.foregroundColor)
                        .font(.title3)
                        HStack {
                            Text((location.state ?? ""))
                            Spacer()
                        }
                        .foregroundColor(WeatherViewConstants.foregroundColor.opacity(0.8))
                        .padding(.bottom, 10)
                        .font(.body)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.getWeatherByLocation(Coordinate(lat: location.lat, lon: location.lon))
                    }
                }
            }
            .padding(20)
            .background(Color.white.opacity(0.2))
            .cornerRadius(20)
            .padding(.horizontal, 32)
        }
    }
    
    private var locationAlert: Alert {
        Alert(title: Text("Location Services Disabled"),
              message: Text("To enable location services, go to Settings. You can continue to access the weather by searching for a city."),
              dismissButton: .default(Text("OK")))
    }
}
