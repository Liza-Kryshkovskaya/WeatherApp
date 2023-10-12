//
//  EndpointTests.swift
//  WeatherAppTests
//
//  Created by Liza Kryshkovskaya on 12.10.23.
//

import XCTest
@testable import WeatherApp

final class EndpointTests: XCTestCase {
    
    func test_weather_endpointURL() throws {
        let apiKey = APISecrets.apiKey
        let latitude = 50.0
        let longitude = 10.0
        let units = "metric"
        let endpoint = Endpoint.weather(latitude: latitude, longitude: longitude, units: units).url()
        
        XCTAssertEqual(endpoint.scheme, "https", "scheme")
        XCTAssertEqual(endpoint.host, "api.openweathermap.org", "host")
        XCTAssertEqual(endpoint.path, "/data/2.5/weather", "path")
        XCTAssertEqual(endpoint.query, "lat=\(latitude)&lon=\(longitude)&units=\(units)&appid=\(apiKey)", "query")
    }
    
    func test_locations_endpointURL() throws {
        let apiKey = APISecrets.apiKey
        let cityName = "any"
        let limit = 10
        let endpoint = Endpoint.locations(cityName: cityName, limit: limit).url()
        
        XCTAssertEqual(endpoint.scheme, "https", "scheme")
        XCTAssertEqual(endpoint.host, "api.openweathermap.org", "host")
        XCTAssertEqual(endpoint.path, "/geo/1.0/direct", "path")
        XCTAssertEqual(endpoint.query, "q=\(cityName)&limit=\(limit)&appid=\(apiKey)", "query")
    }
}
