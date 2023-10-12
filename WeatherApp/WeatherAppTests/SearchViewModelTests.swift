//
//  SearchViewModelTests.swift
//  WeatherAppTests
//
//  Created by Liza Kryshkovskaya on 12.10.23.
//

import XCTest
@testable import WeatherApp

final class SearchViewModelTests: XCTestCase {
    
    func test_init_setsStateByDefault() {
        let (sut, _) = makeSUT()
        
        XCTAssertEqual(sut.city, "")
        XCTAssertEqual(sut.locations, [])
        XCTAssertEqual(sut.error, nil)
        XCTAssertEqual(sut.showLocationErrorAlert, false)
    }
    
    func test_clear_setsInitialValues() {
        let (sut, _) = makeSUT()
        
        sut.clear()
        
        XCTAssertEqual(sut.city, "")
        XCTAssertEqual(sut.locations, [])
        XCTAssertEqual(sut.error, nil)
    }
    
    func test_cancel_triggersCancelAction() {
        var cancelTapped = false
        let weatherLocationService = WeatherLocationServiceMock()
        let locationService = LocationServiceMock()
        let sut = SearchViewModel(
            service: weatherLocationService,
            locationService: locationService,
            onSelect: { _ in },
            onCancelButtonTap: { cancelTapped = true }
        )
        
        sut.cancel()
        
        XCTAssertTrue(cancelTapped)
    }
    
    func test_getWeatherByCurrentLocation_failsWithErrorOnLocationServiceFailure() {
        let error = anyError()
        let (sut, locationService) = makeSUT()
        
        sut.getWeatherByCurrentLocation()
        locationService.complete(with: error)
        
        XCTAssertEqual(sut.showLocationErrorAlert, true)
    }
    
    func test_getWeatherByCurrentLocation_successWithCoordinate() {
        let coordinate = Coordinate(lat: 1, lon: 1)
        var selection = false
        let weatherLocationService = WeatherLocationServiceMock()
        let locationService = LocationServiceMock()
        let sut = SearchViewModel(
            service: weatherLocationService,
            locationService: locationService,
            onSelect: { receivedCoordinate in
                selection = true
                XCTAssertEqual(receivedCoordinate, coordinate)
            },
            onCancelButtonTap: {}
        )
        
        sut.getWeatherByCurrentLocation()
        locationService.complete(with: coordinate)
        
        XCTAssertEqual(sut.showLocationErrorAlert, false)
        XCTAssertTrue(selection)
    }

    private func makeSUT() -> (SearchViewModel, LocationServiceMock) {
        let weatherLocationService = WeatherLocationServiceMock()
        let locationService = LocationServiceMock()
        let sut = SearchViewModel(service: weatherLocationService, locationService: locationService, onSelect: { _ in }, onCancelButtonTap: { })
        return (sut, locationService)
    }
}
