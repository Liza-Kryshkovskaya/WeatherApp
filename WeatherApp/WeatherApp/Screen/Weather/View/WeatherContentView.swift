//
//  WeatherContentView.swift
//  WeatherApp
//
//  Created by Liza Kryshkovskaya on 11.10.23.
//

import SwiftUI

struct WeatherContentView: View {
    let weather: WeatherDisplayModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            locationAndTemperature
            weatherParameters
        }
        .foregroundColor(Color("foreground"))
        .padding(.horizontal, 24)
        .padding(.bottom, 40)
    }
    
    private var locationAndTemperature: some View {
        VStack(spacing: 20) {
            Text(weather.city)
                .font(.largeTitle)
                .padding(.top, 30)

            HStack(spacing: 20) {
                Image(systemName: weather.weatherIconName)
                    .font(.system(size: 92, weight: .bold))
                Text(weather.temperature)
                    .font(.system(size: 92, weight: .bold))
                    .shadow(radius: 30)
            }
            HStack {
                Text(weather.weatherCondition.capitalized)
                Text(" | ")
                Text("H:" + weather.maxTemp)
                Text("L:" + weather.minTemp)
            }
            .font(.system(size: 15))
        }
        .padding(.bottom, 20)
    }
    
    private var weatherParameters: some View {
        VStack(spacing: 10) {
            WeatherDataCell(imageName: "thermometer.high", title: "Feels like", value: weather.feelsLike)
            WeatherDataCell(imageName: "wind", title: "Wind", value: weather.windSpeed)
            WeatherDataCell(imageName: "humidity.fill", title: "Humidity", value: weather.humidity)
            HStack(spacing: 10) {
                WeatherDataHalfCell(imageName: "sunset.fill", title: "Sunset", value: weather.sunset)
                WeatherDataHalfCell(imageName: "sunrise.fill", title: "Sunrise", value: weather.sunrise)
            }
            WeatherDataCell(imageName: "barometer", title: "Pressure", value: weather.pressure)
            WeatherDataCell(imageName: "smoke.fill", title: "Cloudiness", value: weather.clouds)
            WeatherDataCell(imageName: "eye.fill", title: "Visibility", value: weather.visibility)
        }
        .padding(.bottom, 10)
    }
}
