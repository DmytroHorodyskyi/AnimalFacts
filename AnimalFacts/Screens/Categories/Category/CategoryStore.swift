//
//  CategoryStore.swift
//  AnimalFacts
//
//  Created by Dmytro Horodyskyi on 16.09.2025.
//

import Foundation
import ComposableArchitecture

@Reducer
struct CategoryStore {
    
    //MARK: State
    @ObservableState
    struct State {
        var category: FactCategory
    }
}
