//
//  WeatherMapperTests.swift
//  WeatherAppTests
//
//  Created by Liza Kryshkovskaya on 12.10.23.
//

import XCTest
@testable import WeatherApp

final class WeatherMapperTests: XCTestCase {
    func test_map_throwsErrorOnNon200HTTPResponse() throws {
        let jsonData = try! JSONSerialization.data(withJSONObject: [:])
        let statusCode = [199, 201, 300, 400, 500]
        
        
        try statusCode.forEach { code in
            XCTAssertThrowsError(
                try WeatherMapper.map(jsonData, from: anyHTTPURLResponse(statusCode: code))
            )
        }
    }
    
    func test_map_throwsErrorOn200HTTPResponseWithInvalidJSON() throws {
        let invalidJSON = anyData()
        
        XCTAssertThrowsError(
            try WeatherMapper.map(invalidJSON, from: anyHTTPURLResponse(statusCode: 200))
        )
    }
    
    func test_map_deliversErrorOn200HTTPResponseWithEmptyJSON() throws {
        let emptyJSON = try! JSONSerialization.data(withJSONObject: [:])
        
        XCTAssertThrowsError(
            try WeatherMapper.map(emptyJSON, from: anyHTTPURLResponse(statusCode: 200))
        )
    }
    
    func test_map_deliversWeatherModelOn200HTTPResponseWithValidJSON() throws {
        let model = weatherModel()
        let jsonData = try! JSONSerialization.data(withJSONObject: jsonModel())
        let result = try WeatherMapper.map(jsonData, from: anyHTTPURLResponse(statusCode: 200))
        
        XCTAssertEqual(result, model)
    }
    
    func anyURL() -> URL {
        return URL(string: "http://any-url.com")!
    }
    
    func anyHTTPURLResponse(statusCode: Int) -> HTTPURLResponse {
        return HTTPURLResponse(url: anyURL(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
    
    func anyData() -> Data {
        return Data("any data".utf8)
    }
    
    func jsonModel() -> [String : Any] {
        return [
            "weather": [
                [
                    "main": "1",
                    "description": "1",
                    "icon": "1"
                ]
            ],
            "main": [
                "temp": 1.0,
                "feels_like": 1.0,
                "temp_min": 1.0,
                "temp_max": 1.0,
                "pressure": 1,
                "humidity": 1
            ],
            "visibility": 1,
            "wind": [
                "speed": 1.0
            ],
            "clouds": [
                "all": 1
            ],
            "sys": [
                "sunrise": 1,
                "sunset": 1
            ],
            "name": "1",
            "timezone": 1
        ]
    }
    
    func weatherModel() -> CurrentWeather {
        return CurrentWeather(weatherCondition: [WeatherCondition(main: "1", description: "1", icon: "1")], main: CurrentWeatherMain(temp: 1, feelsLike: 1, minTemp: 1, maxTemp: 1, pressure: 1, humidity: 1), visibility: 1, wind: Wind(speed: 1), clouds: Clouds(all: 1), sun: Sun(sunrise: 1, sunset: 1), city: "1", timezone: 1)

    }
}
