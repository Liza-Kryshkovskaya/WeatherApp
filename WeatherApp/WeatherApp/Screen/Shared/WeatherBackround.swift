//
//  WeatherBackround.swift
//  WeatherApp
//
//  Created by Liza Kryshkovskaya on 11.10.23.
//

import SwiftUI

struct WeatherBackround: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color("bgTop"), Color("bgBottom")]), startPoint: .topLeading, endPoint: .bottomLeading).ignoresSafeArea()
    }
}
