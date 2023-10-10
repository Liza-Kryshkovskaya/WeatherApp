//
//  State.swift
//  WeatherApp
//
//  Created by Liza Kryshkovskaya on 10.10.23.
//

import Foundation

enum State {
    case loading
    case loaded(error: String?)
}
