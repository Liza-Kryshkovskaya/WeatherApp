//
//  ErrorView.swift
//  WeatherApp
//
//  Created by Liza Kryshkovskaya on 11.10.23.
//

import SwiftUI

struct ErrorView: View {
    let error: String
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "wifi.exclamationmark")
                .font(.system(size: 50, weight: .bold))
                .opacity(0.7)
            Text("Weather Unavailable")
                .font(.title)
                .fontWeight(.bold)
            Text(error.capitalized)
                .multilineTextAlignment(.center)
                .font(.system(size: 18))
                .lineSpacing(4)
                .opacity(0.7)
            Button(action: {
                action()
            }) {
                Text("Retry")
                    .font(.system(size: 18))
            }
        }
        .foregroundColor(Color("foreground"))
    }
}
