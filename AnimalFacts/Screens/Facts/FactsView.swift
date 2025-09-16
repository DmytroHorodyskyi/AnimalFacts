//
//  FactsView.swift
//  AnimalFacts
//
//  Created by Dmytro Horodyskyi on 16.09.2025.
//

import SwiftUI

struct FactsView: View {
    
    //MARK: Body
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Colors.black.color.opacity(0.25), Colors.black.color.opacity(0)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(height: 8)
                ScrollViewReader { proxy in
                    ScrollView(.horizontal) {
                        HStack() {
                            FactCardView()
                                .frame(width: geometry.size.width)
                            FactCardView()
                                .frame(width: geometry.size.width)
                            FactCardView()
                                .frame(width: geometry.size.width)
                        }
                        .frame(height: geometry.size.height)
                    }
                }
            }
        }
        .background(Colors.purpleBackground.color)
        .navigationTitle("Category title")
        .toolbarRole(.editor)
    }
}

//MARK: - Preview
#Preview {
    FactsView()
}
