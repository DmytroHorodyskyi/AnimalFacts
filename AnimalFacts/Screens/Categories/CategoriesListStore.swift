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
        var isLoading: Bool = false
        var error: String?
    }
    
    //MARK: Action
    enum Action {
        case loadCategories
        case successLoadCategories([FactCategory])
        case failed(Error)
        case eraseError
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
                    }
                    catch {
                        await send(.failed(error))
                    }
                }
                
            case .successLoadCategories(let categories):
                state.isLoading = false
                state.categories = categories.sorted { $0.order < $1.order }
                return .none
                
            case .failed(let error):
                state.isLoading = false
                state.error = error.localizedDescription
                return .none
                
            case .eraseError:
                state.error = nil
                return .none
            }
        }
    }
}
