//
//  WeatherDisplayModel.swift
//  WeatherApp
//
//  Created by Liza Kryshkovskaya on 10.10.23.
//

import Foundation

struct WeatherDisplayModel {
    let city: String
    let temperature: String
    let weatherCondition: String
    let minTemp: String
    let maxTemp: String
    let visibility: String
    let windSpeed: String
    let clouds: String
    let sunrise: String
    let sunset: String
    let humidity: String
    let pressure: String
    let feelsLike: String

    init(from currentWeather: CurrentWeather) {
        self.city = currentWeather.city
        self.temperature = String(currentWeather.main.temp)
        self.weatherCondition = currentWeather.weatherCondition.first?.description ?? ""
        self.minTemp = String(currentWeather.main.minTemp)
        self.maxTemp = String(currentWeather.main.maxTemp)
        self.visibility = String(currentWeather.visibility)
        self.windSpeed = String(currentWeather.wind.speed)
        self.clouds = String(currentWeather.clouds.all)
        self.sunrise = String(currentWeather.sun.sunrise)
        self.sunset = String(currentWeather.sun.sunset)
        self.humidity = String(currentWeather.main.humidity)
        self.pressure = String(currentWeather.main.pressure)
        self.feelsLike = String(currentWeather.main.feelsLike)
    }
}
