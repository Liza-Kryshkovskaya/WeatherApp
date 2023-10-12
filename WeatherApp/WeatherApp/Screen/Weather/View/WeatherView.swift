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
        ZStack {
            WeatherBackround()
            content
            toolBar
        }
    }
    
    private var content: some View {
        ZStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .loaded(let error):
                if let error = error {
                    ErrorView(error: error) { viewModel.retry() }
                } else {
                    if let weather = viewModel.weather {
                        WeatherContentView(weather: weather)
                    } else {
                        ErrorView(error: "Unknown error.") { viewModel.retry() }
                    }
                }
            }
        }
    }
    
    private var toolBar: some View {
        VStack(spacing: WeatherViewConstants.noSpacing) {
            Spacer()
            Rectangle()
                .foregroundColor(WeatherViewConstants.foregroundColor)
                .cornerRadius(WeatherViewConstants.cornerRadius, corners: [.topLeft, .topRight])
                .frame(height: WeatherViewConstants.toolBarHeight)
            HStack {
                Button {
                    withAnimation {
                        viewModel.toggleUnits()
                    }
                } label: {
                    HStack {
                        Image(systemName: "thermometer.high")
                        Text(viewModel.units == .metric ? "C°" : "F°")
                    }
                }
                Spacer()
                Button {
                    viewModel.searchLocation()
                } label: {
                    Image(systemName: "magnifyingglass")
                }
            }
            .font(WeatherViewConstants.buttonFont)
            .padding(.horizontal, WeatherViewConstants.horizontalPadding)
            .background(WeatherViewConstants.foregroundColor.ignoresSafeArea())
            .foregroundColor(WeatherViewConstants.bgColor)
        }
    }
}

