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
    private let iconName: String?

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
        self.iconName = currentWeather.weatherCondition.first?.icon
    }
}

extension WeatherDisplayModel {
    var weatherIconName: String {
        switch iconName {
        case "01d": return "sun.max.fill"
        case "01n": return "moon.stars.fill"
        case "02d": return "cloud.sun.fill"
        case "02n": return "cloud.moon.fill"
        case "03n", "03d": return "cloud.fill"
        case "04d", "04n": return "smoke.fill"
        case "09d", "09n": return "cloud.drizzle.fill"
        case "10d": return "cloud.sun.rain.fill"
        case "10n": return "cloud.moon.rain.fill"
        case "11d": return "cloud.sun.bolt.fill"
        case "11n": return "cloud.moon.bolt.fill"
        case "13d", "13n": return "snow"
        case "50d": return "sun.haze.fill"
        case "50n": return "cloud.fog.fill"
        default: return "cloud.fill"
        }
    }
}
