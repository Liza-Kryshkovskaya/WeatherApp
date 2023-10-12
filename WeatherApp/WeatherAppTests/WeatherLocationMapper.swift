//
//  WeatherLocationMapper.swift
//  WeatherAppTests
//
//  Created by Liza Kryshkovskaya on 12.10.23.
//

import XCTest
@testable import WeatherApp

final class WeatherLocationMapperTests: XCTestCase {
    func test_map_throwsErrorOnNon200HTTPResponse() throws {
        let jsonData = try! JSONSerialization.data(withJSONObject: [:])
        let statusCode = [199, 201, 300, 400, 500]
        
        
        try statusCode.forEach { code in
            XCTAssertThrowsError(
                try WeatherLocationMapper.map(jsonData, from: anyHTTPURLResponse(statusCode: code))
            )
        }
    }
    
    func test_map_throwsErrorOn200HTTPResponseWithInvalidJSON() throws {
        let invalidJSON = anyData()
                
        XCTAssertThrowsError(
            try WeatherLocationMapper.map(invalidJSON, from: anyHTTPURLResponse(statusCode: 200))
        )
    }
    
    func test_map_deliversErrorOn200HTTPResponseWithEmptyJSON() throws {
        let emptyJSON = try! JSONSerialization.data(withJSONObject: [:])
        
        XCTAssertThrowsError(
            try WeatherLocationMapper.map(emptyJSON, from: anyHTTPURLResponse(statusCode: 200))
        )
    }
    
    func test_map_deliversLocationsListOn200HTTPResponseWithValidJSONList() throws {
        let locations = locationsModel()
        let jsonData = try! JSONSerialization.data(withJSONObject: jsonList())
        let result = try WeatherLocationMapper.map(jsonData, from: anyHTTPURLResponse(statusCode: 200))
        
        XCTAssertEqual(result, locations)
    }
    
    private func locationsModel() -> [WeatherLocation] {
        return [WeatherLocation(name: "1", lat: 1, lon: 1, country: "1", state: "1"),
                WeatherLocation(name: "2", lat: 2, lon: 2, country: "2", state: "2")]
    }
    
    private func jsonList() -> [[String : Any]] {
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
