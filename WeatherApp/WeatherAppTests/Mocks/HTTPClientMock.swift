//
//  HTTPClientMock.swift
//  WeatherAppTests
//
//  Created by Liza Kryshkovskaya on 12.10.23.
//

import Foundation
@testable import WeatherApp

final class HTTPClientMock: HTTPClient {
    private class Task: HTTPClientTask {
        func cancel() {}
    }
    
    var completions = [(Result<(Data, HTTPURLResponse), Error>) -> Void]()
    
    func get(from url: URL, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void) -> WeatherApp.HTTPClientTask {
        completions.append(completion)
        return Task()
    }
    
    func complete(with error: Error, at index: Int = 0) {
        completions[index](.failure(error))
    }
    
    func complete(with response: (Data, HTTPURLResponse), at index: Int = 0) {
        completions[index](.success(response))
    }
}
