//
//  CurrentLocationService.swift
//  WeatherApp
//
//  Created by Liza Kryshkovskaya on 9.10.23.
//

import CoreLocation

final class CurrentLocationService: NSObject, LocationService {
    private let locationManager = CLLocationManager()
    private var completion: ((Result<Coordinate, Error>) -> Void)?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    func getCurrentLocation(completion: @escaping (Result<Coordinate, Error>) -> Void) {
        self.completion = completion
    }
    
    private func coordinateByDefault() -> Coordinate {
        return Coordinate(lat: 44.34, lon: 10.99)
    }
}

extension CurrentLocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestLocation()
        case .notDetermined:
            break
        default:
            completion?(.failure(LocationServiceError.accessDenied))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let coordinate = Coordinate(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
            completion?(.success(coordinate))
        } else {
            completion?(.success(coordinateByDefault()))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completion?(.failure(LocationServiceError.locationNotFound))
    }
}
