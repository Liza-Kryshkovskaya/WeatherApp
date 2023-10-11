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
            backround
            content
            toolBar
        }
    }
    
    private var backround: some View {
        LinearGradient(gradient: Gradient(colors: [Color("bgTop"), Color("bgBottom")]), startPoint: .topLeading, endPoint: .bottomLeading).ignoresSafeArea()
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
        VStack(spacing: 0) {
            Spacer()
            Rectangle()
                .foregroundColor(Color("foreground"))
                .cornerRadius(20, corners: [.topLeft, .topRight])
                .frame(height: 20)
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
            .font(.system(size: 20, weight: .semibold))
            .padding(.horizontal, 34)
            .background(Color("foreground").ignoresSafeArea())
            .foregroundColor(Color("bgTop"))
        }
    }
}

