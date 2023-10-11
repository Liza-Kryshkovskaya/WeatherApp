//
//  WeatherDataHalfCell.swift
//  WeatherApp
//
//  Created by Liza Kryshkovskaya on 11.10.23.
//

import SwiftUI

struct WeatherDataHalfCell: View {
    let imageName: String
    let title: String
    let value: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: imageName)
                Text(title.uppercased())
                    .fontWeight(.semibold)
                    .font(.system(size: 15))
                Spacer()
            }
            Text(value)
                .fontWeight(.semibold)
                .font(.title2)
                .padding(24)
        }
        .padding(16)
        .background(Color.white.opacity(0.2))
        .cornerRadius(20)
    }
}
