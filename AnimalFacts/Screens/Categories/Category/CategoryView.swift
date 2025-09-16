//
//  CategoryView.swift
//  AnimalFacts
//
//  Created by Dmytro Horodyskyi on 16.09.2025.
//

import SwiftUI

struct CategoryView: View {
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(Colors.white.color)
            HStack {
                Image(systemName: "cross")
                    .resizable()
                    .frame(width: 121, height: 90)
                    .padding(5)
                VStack(alignment: .leading) {
                    Text("Title")
                        .font(Fonts.regular16.font)
                        .foregroundStyle(Colors.black.color)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Subtitle")
                        .font(Fonts.regular14.font)
                        .foregroundStyle(Colors.black.color.opacity(0.5))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    HStack(spacing: 4) {
                        Images.lock.image
                        Text("Premium")
                            .font(Fonts.regular16.font)
                            .foregroundStyle(Colors.accentBlue.color)
                    }
                }
                .padding(8)
            }
            HStack {
                Spacer()
                Images.comingSoonMark.image
            }
        }
        .overlay(Colors.black.color.opacity(0.6))
        .cornerRadius(6)
        .shadow(radius: 4, y: 2)
    }
}

#Preview {
    CategoryView()
}
