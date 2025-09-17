//
//  FactsStore.swift
//  AnimalFacts
//
//  Created by Dmytro Horodyskyi on 16.09.2025.
//

import Foundation
import ComposableArchitecture

@Reducer
struct FactsStore {
    
    //MARK: State
    @ObservableState
    struct State {
        var title: String
        var contents: [FactItem]
        var currentIndex: Int = 0
        var cards: IdentifiedArrayOf<FactCardStore.State>
        
        init(
            title: String,
            contents: [FactItem]
        ) {
            self.title = title
            self.contents = contents
            self.cards = IdentifiedArrayOf(
                uniqueElements: contents.enumerated().map { index, item in
                    FactCardStore.State(
                        contentIndex: index,
                        content: item
                    )
                }
            )
        }
    }
    
    //MARK: Action
    enum Action {
        case setCurrentIndex(Int)
        case card(IdentifiedActionOf<FactCardStore>)
    }
    
    //MARK: Body
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .card(.element(id: _, action: .nextTapped)):
                state.currentIndex = min(
                    state.currentIndex + 1,
                    state.contents.count - 1
                )
                return .none
                
            case .card(.element(id: _, action: .previousTapped)):
                state.currentIndex = max(
                    state.currentIndex - 1,
                    0
                )
                return .none
                
            case .setCurrentIndex(let value):
                state.currentIndex = value
                return .none
            }
        }
        .forEach(\.cards, action: \.card) {
            FactCardStore()
        }
    }
}
