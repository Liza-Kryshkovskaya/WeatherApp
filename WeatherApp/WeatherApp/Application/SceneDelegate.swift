//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by Liza Kryshkovskaya on 7.10.23.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        let session = URLSession.shared
        let httpClient = URLSessionHTTPClient(session: session)
        let currentWeatherService = CurrentWeatherNetworkService(client: httpClient)
        let weatherViewModel = WeatherViewModel(service: currentWeatherService)
        let weatherView = WeatherView(viewModel: weatherViewModel)
        let weatherLocationNetworkService = WeatherLocationNetworkService(client: httpClient)
        let searchViewModel = SearchViewModel(service: weatherLocationNetworkService) { location in
            print("Selected location = ", location.name, location.lat, location.lon)
        }
        let searchView = SearchView(viewModel: searchViewModel)
        window?.rootViewController = UIHostingController(rootView: weatherView)
        window?.rootViewController = UIHostingController(rootView: searchView)
        window?.makeKeyAndVisible()
    }
}

