//
//  HTTPClient.swift
//  WeatherApp
//
//  Created by Liza Kryshkovskaya on 7.10.23.
//

import Foundation

protocol HTTPClient {
    func get(from url: URL, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void) -> HTTPClientTask
}
