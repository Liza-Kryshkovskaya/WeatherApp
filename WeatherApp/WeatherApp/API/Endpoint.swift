//
//  Endpoint.swift
//  WeatherApp
//
//  Created by Liza Kryshkovskaya on 9.10.23.
//

import Foundation

enum Endpoint {
    case locations(cityName: String, limit: Int)
    case weather(latitude: Double, longitude: Double)

    private var baseURL: URL {
        URL(string: "https://api.openweathermap.org")!
    }
        
    func url() -> URL {
        var components = URLComponents()
        components.scheme = baseURL.scheme
        components.host = baseURL.host
        
        switch self {
        case .locations(let cityName, let limit):
            components.path = baseURL.path + "/geo/1.0/direct"
            components.queryItems = [
                URLQueryItem(name: "q", value: cityName),
                URLQueryItem(name: "limit", value: "\(limit)"),
                URLQueryItem(name: "appid", value: "\(APISecrets.apiKey)")
            ]
            return components.url!
            
        case .weather(let latitude, let longitude):
            components.path = baseURL.path + "/data/2.5/weather"
            components.queryItems = [
                URLQueryItem(name: "lat", value: "\(latitude)"),
                URLQueryItem(name: "lon", value: "\(longitude)"),
                URLQueryItem(name: "appid", value: "\(APISecrets.apiKey)")
            ]
            return components.url!
        }
    }
}
