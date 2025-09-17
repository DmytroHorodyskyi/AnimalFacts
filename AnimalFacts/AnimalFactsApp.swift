//
//  AnimalFactsApp.swift
//  AnimalFacts
//
//  Created by Dmytro Horodyskyi on 16.09.2025.
//

import SwiftUI
import ComposableArchitecture

@main
struct AnimalFactsApp: App {
    
    //MARK: Body
    var body: some Scene {
        WindowGroup {
            CategoriesCoordinatorView(store: Store(
                initialState: CategoriesCoordinatorStore.State(),
                reducer: { CategoriesCoordinatorStore() }
            ))
        }
    }
}
