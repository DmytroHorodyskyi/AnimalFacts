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
        case setLoading(Bool)
        case successLoadCategories([FactCategory])
        case failed(String)
        case didTapCategory(FactCategory)
        case offlineCategories([FactCategory])
    }
    
    @Dependency(\.networkManager) var networkManager
    @Dependency(\.storageManager) var storageManager
    
    //MARK: Body
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .loadCategories:
                return .run { send in
                    if let cached = try? await storageManager.fetchCategories(),
                       !cached.isEmpty {
                        await send(.offlineCategories(cached))
                    } else {
                        await send(.setLoading(true))
                    }
                    
                    do {
                        let result: [FactCategory] = try await networkManager.get(.animals)
                        try await storageManager.saveCategories(result)
                        await send(.successLoadCategories(result))
                    } catch {
                        if let cached = try? await storageManager.fetchCategories(),
                           !cached.isEmpty {
                            await send(.offlineCategories(cached))
                        } else {
                            await send(.failed(error.localizedDescription))
                        }
                    }
                    
                }
                
            case .setLoading(let isLoading):
                state.isLoading = isLoading
                return .none
                
            case .successLoadCategories(let categories),
                    .offlineCategories(let categories):
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
