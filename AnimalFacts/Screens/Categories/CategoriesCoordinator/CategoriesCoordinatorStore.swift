//
//  CategoriesCoordinatorStore.swift
//  AnimalFacts
//
//  Created by Dmytro Horodyskyi on 17.09.2025.
//

import Foundation
import ComposableArchitecture

@Reducer
struct CategoriesCoordinatorStore {
    
    //MARK: State
    @ObservableState
    struct State {
        var activeAlert: AlertType?
        var navigationStack = StackState<Path.State>()
        
        var list = CategoriesListStore.State()
    }
    
    //MARK: Action
    enum Action {
        
        case showAlertPaid(Bool, category: FactCategory)
        case showAlertComingSoon(Bool)
        case hideAlert
        
        case showAdTapped(for: FactCategory)
        case adFinished(for: FactCategory)
        
        case navigationAction(StackActionOf<Path>)
        case navigateToFacts(FactCategory)
        
        case list(CategoriesListStore.Action)
    }
    
    //MARK: Body
    var body: some ReducerOf<Self> {
        Scope(state: \.list, action: \.list) { CategoriesListStore() }
        
        Reduce { state, action in
            switch action {
                
            case .list(.didTapCategory(let category)):
                switch category.statusValue {
                case .free:
                    return .send(.navigateToFacts(category))
                case .paid:
                    return .send(.showAlertPaid(true, category: category))
                case .comingSoon:
                    return .send(.showAlertComingSoon(true))
                }
                
            case .hideAlert:
                state.activeAlert = nil
                return .none
                
            case .showAlertPaid(let value, category: let category):
                state.activeAlert = value ? .paid(category) : nil
                return .none
                
            case .showAlertComingSoon(let value):
                state.activeAlert = value ? .comingSoon : nil
                return .none
                
            case .showAdTapped(for: let category):
                state.list.isLoading = true
                return .run { send in
                    try await Task.sleep(for: .seconds(2))
                    await send(.adFinished(for: category))
                }
                
            case .adFinished(for: let category):
                state.list.isLoading = false
                return .send(.navigateToFacts(category))
                
            case .navigateToFacts(let category):
                state.navigationStack.append(Path.State.facts(
                    FactsStore.State(
                        title: category.title,
                        contents: Array(category.content)
                    )
                ))
                return .none
                
            default: return .none
            }
        }
        .forEach(\.navigationStack, action: \.navigationAction)
    }
}

//MARK: - Path
extension CategoriesCoordinatorStore {
    @Reducer
    enum Path {
        case facts(FactsStore)
    }
    
    enum AlertType {
        case error(String)
        case paid(FactCategory)
        case comingSoon
    }
}
