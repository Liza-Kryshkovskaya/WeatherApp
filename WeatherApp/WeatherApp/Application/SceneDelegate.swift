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
    
    private lazy var navigationController = UINavigationController(rootViewController: makeWeatherViewController())
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        navigationController.isNavigationBarHidden = true
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    private func makeWeatherViewController() -> UIViewController {
        let session = URLSession.shared
        let httpClient = URLSessionHTTPClient(session: session)
        let currentWeatherService = CurrentWeatherNetworkService(client: httpClient)
        let locationService = CurrentLocationService()
        let weatherViewModel = WeatherViewModel(service: currentWeatherService, locationService: locationService)
        let weatherView = WeatherView(viewModel: weatherViewModel)
        let weatherLocationNetworkService = WeatherLocationNetworkService(client: httpClient)
        let searchViewModel = SearchViewModel(
            service: weatherLocationNetworkService,
            locationService: locationService) { [weak self] coordinate in
                weatherViewModel.getCurrentWeatherBy(coordinate)
                self?.dismissView()
            } onCancelButtonTap: { [weak self] in
                self?.dismissView()
            }
        let searchView = SearchView(viewModel: searchViewModel)
        let searchViewController = UIHostingController(rootView: searchView)
    
        weatherViewModel.onSearchTap = { [weak self] in
            self?.showViewController(searchViewController)
        }
        
        return UIHostingController(rootView: weatherView)
    }
    
    private func showViewController(_ vc: UIViewController) {
        navigationController.pushViewController(vc, animated: true)
    }
    
    private func dismissView() {
        navigationController.popViewController(animated: true)
    }
}
