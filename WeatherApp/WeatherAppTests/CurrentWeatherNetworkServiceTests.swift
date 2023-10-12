//
//  CurrentWeatherNetworkServiceTests.swift
//  WeatherAppTests
//
//  Created by Liza Kryshkovskaya on 12.10.23.
//

import XCTest
@testable import WeatherApp

final class CurrentWeatherNetworkServiceTests: XCTestCase {
    func test_getCurrentWeatherByCoordinate_succeedsOnClientSuccessWithWeatherModel() {
        let jsonData = try! JSONSerialization.data(withJSONObject: jsonModel())
        let client = HTTPClientMock()
        let sut = CurrentWeatherNetworkService(client: client)
        let expectedResult: Result<CurrentWeather, Error> = .success(weatherModel())
        let exp = expectation(description: "Wait for completion")
        
        sut.getCurrentWeatherBy(coordinate: Coordinate(lat: 1, lon: 1), units: "metric") { recievedResult in
            switch (recievedResult, expectedResult) {
            case let (.success(recievedValue), .success(expectedValue)):
                XCTAssertEqual(recievedValue, expectedValue)
                
            case let (.failure(recievedError as NSError), .failure(expectedError as NSError)):
                XCTAssertEqual(recievedError, expectedError)
                
            default:
                XCTFail("Expect \(expectedResult) but recieved \(recievedResult)")
            }
            exp.fulfill()
        }
        client.complete(with: (jsonData, anyHTTPURLResponse(statusCode: 200)))

        wait(for: [exp], timeout: 3.0)
    }
    
    func test_getCurrentWeatherByCoordinate_failsOnClientFailsWithError() {
        let error = anyError()
        let client = HTTPClientMock()
        let sut = CurrentWeatherNetworkService(client: client)
        let expectedResult: Result<CurrentWeather, Error> = .failure(error)
        let exp = expectation(description: "Wait for completion")

        sut.getCurrentWeatherBy(coordinate: Coordinate(lat: 1, lon: 1), units: "metric") { recievedResult in
            switch (recievedResult, expectedResult) {
            case let (.success(recievedValue), .success(expectedValue)):
                XCTAssertEqual(recievedValue, expectedValue)
                
            case let (.failure(recievedError as NSError), .failure(expectedError as NSError)):
                XCTAssertEqual(recievedError, expectedError)
                
            default:
                XCTFail("Expect \(expectedResult) but recieved \(recievedResult)")
            }
            exp.fulfill()
        }
        client.complete(with: anyError())

        wait(for: [exp], timeout: 3.0)
    }
    
    private func weatherModel() -> CurrentWeather {
        return CurrentWeather(weatherCondition: [WeatherCondition(main: "1", description: "1", icon: "1")], main: CurrentWeatherMain(temp: 1, feelsLike: 1, minTemp: 1, maxTemp: 1, pressure: 1, humidity: 1), visibility: 1, wind: Wind(speed: 1), clouds: Clouds(all: 1), sun: Sun(sunrise: 1, sunset: 1), city: "1", timezone: 1)

    }
    
    private func jsonModel() -> [String : Any] {
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
}
