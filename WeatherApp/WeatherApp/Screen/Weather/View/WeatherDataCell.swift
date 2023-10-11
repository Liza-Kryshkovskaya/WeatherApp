//
//  WeatherDataCell.swift
//  WeatherApp
//
//  Created by Liza Kryshkovskaya on 11.10.23.
//

import SwiftUI

struct WeatherDataCell: View {
    let imageName: String
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
            Text(title.uppercased())
                .fontWeight(.semibold)
                .font(.system(size: 15))
            Spacer()
            Text(value)
                .fontWeight(.semibold)
        }
        .padding(20)
        .background(Color.white.opacity(0.2))
        .cornerRadius(20)
    }
}
