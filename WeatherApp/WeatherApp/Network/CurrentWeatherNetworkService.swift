//
//  CurrentWeatherNetworkService.swift
//  WeatherApp
//
//  Created by Liza Kryshkovskaya on 7.10.23.
//

import Foundation

final class CurrentWeatherNetworkService: CurrentWeatherService {
    private let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func getCurrentWeather(completion: @escaping (Result<CurrentWeather, Error>) -> Void) {
        let lat = "44.34"
        let lon = "10.99"
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(APISecrets.apiKey)")!
        
        client.get(from: url) { result in
            switch result {
            case .success(let (data, response)):
                do {
                    let model = try WeatherMapper.map(data, from: response)
                    completion(.success(model))
                } catch {
                    completion(.failure(NetworkError.invalidData))
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
