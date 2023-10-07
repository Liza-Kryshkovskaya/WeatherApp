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
        let weatherViewModel = WeatherViewModel()
        let weatherView = WeatherView(viewModel: weatherViewModel)
        window?.rootViewController = UIHostingController(rootView: weatherView)
        window?.makeKeyAndVisible()
    }
}

