//
//  SharedTestHelpers.swift
//  WeatherAppTests
//
//  Created by Liza Kryshkovskaya on 12.10.23.
//

import Foundation

func anyURL() -> URL {
    return URL(string: "http://any-url.com")!
}

func anyHTTPURLResponse(statusCode: Int) -> HTTPURLResponse {
    return HTTPURLResponse(url: anyURL(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
}

func anyData() -> Data {
    return Data("any data".utf8)
}

func anyError() -> NSError {
    NSError(domain: "test", code: 0)
}
