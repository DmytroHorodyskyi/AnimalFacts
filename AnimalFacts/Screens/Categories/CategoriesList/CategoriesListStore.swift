//
//  CategoriesListStore.swift
//  AnimalFacts
//
//  Created by Dmytro Horodyskyi on 16.09.2025.
//

import Foundation
import ComposableArchitecture

@Reducer
struct CategoriesListStore {
    
    //MARK: State
    @ObservableState
    struct State {
        var categories: [FactCategory] = []
        var isLoading = false
    }

    //MARK: Action
    enum Action {
        
        case loadCategories
        case successLoadCategories([FactCategory])
        case failed(String)
        case didTapCategory(FactCategory)
    }

    @Dependency(\.networkManager) var networkManager

    //MARK: Body
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loadCategories:
                state.isLoading = true
                return .run { send in
                    do {
                        let result: [FactCategory] = try await networkManager.get(.animals)
                        await send(.successLoadCategories(result))
                    } catch {
                        await send(.failed(error.localizedDescription))
                    }
                }

            case .successLoadCategories(let categories):
                state.isLoading = false
                state.categories = categories.sorted { $0.order < $1.order }
                return .none

            case .failed:
                state.isLoading = false
                return .none

            case .didTapCategory:
                return .none
            }
        }
    }
}
