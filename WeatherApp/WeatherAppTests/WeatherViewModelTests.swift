//
//  WeatherViewModelTests.swift
//  WeatherAppTests
//
//  Created by Liza Kryshkovskaya on 12.10.23.
//

import XCTest
@testable import WeatherApp

final class WeatherViewModelTests: XCTestCase {
    
    func test_init_setsStateByDefault() {
        let sut = makeSUT()
        XCTAssertEqual(sut.weather, nil)
        XCTAssertEqual(sut.units, .metric)
        XCTAssertEqual(sut.state, .loading)
    }
    
    func test_toggleUnits() {
        let sut = makeSUT()
        sut.toggleUnits()
        XCTAssertEqual(sut.units, .imperial)
        sut.toggleUnits()
        XCTAssertEqual(sut.units, .metric)
    }
    
    func test_searchLocation_triggersOnSearchTapAction() {
        let sut = makeSUT()
        var searchTapped = false
        sut.onSearchTap = {
            searchTapped = true
        }
        sut.searchLocation()
        XCTAssertTrue(searchTapped)
    }
    
    private func makeSUT() -> WeatherViewModel {
        let weatherService = CurrentWeatherServiceMock()
        let locationService = LocationServiceMock()
        return WeatherViewModel(weatherService: weatherService, locationService: locationService)
    }
}
