//
//  CategoriesListView.swift
//  AnimalFacts
//
//  Created by Dmytro Horodyskyi on 16.09.2025.
//

import SwiftUI

struct CategoriesListView: View {
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    NavigationLink(destination: FactsView()) {
                        CategoryView()
                    }
                }
            }
            .padding()
            .background(Colors.purpleBackground.color)
        }
        .tint(Colors.black.color)
    }
}

#Preview {
    CategoriesListView()
}
