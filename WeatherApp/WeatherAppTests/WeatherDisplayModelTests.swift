//
//  WeatherDisplayModelTests.swift
//  WeatherAppTests
//
//  Created by Liza Kryshkovskaya on 12.10.23.
//

import XCTest
@testable import WeatherApp

final class WeatherDisplayModelTests: XCTestCase {
    func test_init_setCurrentWeatherValues() {
        let currentWeather = CurrentWeather(
            weatherCondition: [WeatherCondition(main: "Cloudy", description: "Cloudy skies", icon: "04d")],
            main: CurrentWeatherMain(temp: 20.0, feelsLike: 18.5, minTemp: 18.0, maxTemp: 22.0, pressure: 1015, humidity: 65),
            visibility: 10000,
            wind: Wind(speed: 5.0),
            clouds: Clouds(all: 40),
            sun: Sun(sunrise: 1633944000, sunset: 1633986000),
            city: "Test City",
            timezone: 7200
        )
        
        let sut = WeatherDisplayModel(from: currentWeather)
        
        XCTAssertEqual(sut.city, "Test City")
        XCTAssertEqual(sut.temperature, "20°")
        XCTAssertEqual(sut.weatherCondition, "Cloudy skies")
        XCTAssertEqual(sut.minTemp, "18°")
        XCTAssertEqual(sut.maxTemp, "22°")
        XCTAssertEqual(sut.visibility, "10000 m")
        XCTAssertEqual(sut.windSpeed, "5 m/s")
        XCTAssertEqual(sut.clouds, "40%")
        XCTAssertEqual(sut.humidity, "65%")
        XCTAssertEqual(sut.pressure, "1015 hPa")
        XCTAssertEqual(sut.feelsLike, "18°")
        XCTAssertEqual(sut.weatherIconName, "smoke.fill")
        XCTAssertEqual(sut.sunset, "23:00")
        XCTAssertEqual(sut.sunrise, "11:20")
    }
    
    func test_init_setSecondCurrentWeatherValues() {
        let currentWeather = CurrentWeather(
            weatherCondition: [WeatherCondition(main: "Rain", description: "Rainy", icon: "10d")],
            main: CurrentWeatherMain(temp: 15.0, feelsLike: 12.5, minTemp: 8.0, maxTemp: 16.0, pressure: 1034, humidity: 73),
            visibility: 10000,
            wind: Wind(speed: 3.0),
            clouds: Clouds(all: 100),
            sun: Sun(sunrise: 1633941000, sunset: 1633981000),
            city: "Second City",
            timezone: 7200
        )
        
        let sut = WeatherDisplayModel(from: currentWeather)
        
        XCTAssertEqual(sut.city, "Second City")
        XCTAssertEqual(sut.temperature, "15°")
        XCTAssertEqual(sut.weatherCondition, "Rainy")
        XCTAssertEqual(sut.minTemp, "8°")
        XCTAssertEqual(sut.maxTemp, "16°")
        XCTAssertEqual(sut.visibility, "10000 m")
        XCTAssertEqual(sut.windSpeed, "3 m/s")
        XCTAssertEqual(sut.clouds, "100%")
        XCTAssertEqual(sut.humidity, "73%")
        XCTAssertEqual(sut.pressure, "1034 hPa")
        XCTAssertEqual(sut.feelsLike, "12°")
        XCTAssertEqual(sut.weatherIconName, "cloud.sun.rain.fill")
        XCTAssertEqual(sut.sunset, "21:36")
        XCTAssertEqual(sut.sunrise, "10:30")
    }

}
