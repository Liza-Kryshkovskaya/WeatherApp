//
//  URLSessionHTTPClientTask.swift
//  WeatherApp
//
//  Created by Liza Kryshkovskaya on 7.10.23.
//

import Foundation

struct URLSessionHTTPClientTask: HTTPClientTask {
    let sessionTask: URLSessionTask
    
    func cancel() {
        sessionTask.cancel()
    }
}

final class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func get(from url: URL, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void) -> HTTPClientTask {
        let task = session.dataTask(with: url) { data, response, error in
            completion ( Result {
                if let error = error {
                    throw error
                } else if let data = data, let response = response as? HTTPURLResponse {
                    return (data, response)
                } else {
                    throw NetworkError.unexpectedError
                }
            })
        }
        task.resume()
        return URLSessionHTTPClientTask(sessionTask: task)
    }
}
