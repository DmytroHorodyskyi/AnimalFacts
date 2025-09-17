//
//  FactCardStore.swift
//  AnimalFacts
//
//  Created by Dmytro Horodyskyi on 16.09.2025.
//

import Foundation
import ComposableArchitecture

@Reducer
struct FactCardStore {
    
    //MARK: State
    @ObservableState
    struct State: Identifiable {
        
        let contentIndex: Int
        var content: FactItem
        
        var id: Int { contentIndex }
    }
    
    //MARK: Action
    enum Action {
        case nextTapped
        case previousTapped
    }
}
