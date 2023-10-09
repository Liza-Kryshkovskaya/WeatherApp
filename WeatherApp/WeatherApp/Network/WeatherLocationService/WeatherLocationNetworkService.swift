//
//  WeatherLocationNetworkService.swift
//  WeatherApp
//
//  Created by Liza Kryshkovskaya on 8.10.23.
//

import Foundation

final class WeatherLocationNetworkService: WeatherLocationService {
    private let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func getLocationsBy(cityName: String, completion: @escaping (Result<[WeatherLocation], Error>) -> Void) {
        let url = Endpoint.locations(cityName: cityName, limit: 10).url()

        client.get(from: url) { result in
            switch result {
            case .success(let (data, response)):
                do {
                    let model = try WeatherLocationMapper.map(data, from: response)
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
