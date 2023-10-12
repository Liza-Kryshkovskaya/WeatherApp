//
//  WeatherLocationNetworkServiceTests.swift
//  WeatherAppTests
//
//  Created by Liza Kryshkovskaya on 12.10.23.
//

import XCTest
@testable import WeatherApp

final class WeatherLocationNetworkServiceTests: XCTestCase {
    func test_getLocationsByCityName_succeedsOnClientSuccessWithWeatherModel() {
        let jsonData = try! JSONSerialization.data(withJSONObject: jsonModel())
        let client = HTTPClientMock()
        let sut = WeatherLocationNetworkService(client: client)
        let expectedResult: Result<[WeatherLocation], Error> = .success(locationsModel())
        let exp = expectation(description: "Wait for completion")
        
        sut.getLocationsBy(cityName: "any", limit: 10) { recievedResult in
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
    
    func test_getLocationsByCityName_failsOnClientFailsWithError() {
        let error = anyError()
        let client = HTTPClientMock()
        let sut = WeatherLocationNetworkService(client: client)
        let expectedResult: Result<[WeatherLocation], Error> = .failure(error)
        let exp = expectation(description: "Wait for completion")

        sut.getLocationsBy(cityName: "any", limit: 10) { recievedResult in
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
    
    private func locationsModel() -> [WeatherLocation] {
        return [WeatherLocation(name: "1", lat: 1, lon: 1, country: "1", state: "1"),
                WeatherLocation(name: "2", lat: 2, lon: 2, country: "2", state: "2")]
    }
    
    private func jsonModel() -> [[String : Any]] {
        return [
            [
                "name": "1",
                "lat": 1.0,
                "lon": 1.0,
                "country": "1",
                "state": "1"
            ],
            [
                "name": "2",
                "lat": 2.0,
                "lon": 2.0,
                "country": "2",
                "state": "2"
            ]
        ]
    }
}
