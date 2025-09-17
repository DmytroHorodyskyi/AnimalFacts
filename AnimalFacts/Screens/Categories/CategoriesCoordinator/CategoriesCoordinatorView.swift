//
//  CategoriesCoordinatorView.swift
//  AnimalFacts
//
//  Created by Dmytro Horodyskyi on 17.09.2025.
//

import SwiftUI
import ComposableArchitecture

struct CategoriesCoordinatorView: View {
    
    @Perception.Bindable var store: StoreOf<CategoriesCoordinatorStore>
    
    //MARK: Body
    var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(
                state: \.navigationStack,
                action: \.navigationAction
            )) {
                CategoriesListView(
                    store: store.scope(
                        state: \.list,
                        action: \.list
                    )
                )
            } destination: { store in
                switch store.case {
                case .facts(let store):
                    FactsView(store: store)
                }
            }
            .tint(Colors.black.color)
            .alert(isPresented: Binding(
                get: { store.activeAlert != nil },
                set: { _ in store.send(.hideAlert) }
            )) {
                alertView
            }
        }
    }
}

//MARK: - Alert
private extension CategoriesCoordinatorView {
    
    var alertView: Alert {
        switch store.activeAlert {
        case .error(let message):
            return Alert(
                title: Text("Error"),
                message: Text(message),
                dismissButton: .default(Text("Ok"))
            )
        case .paid(let category):
            return Alert(
                title: Text("Watch Ad to continue"),
                primaryButton: .destructive(Text("Cancel")),
                secondaryButton: .default(Text("Show ad")) {
                    store.send(.showAdTapped(for: category))
                }
            )
        case .comingSoon:
            return Alert(
                title: Text("This category is coming soon"),
                dismissButton: .default(Text("Ok"))
            )
        case .none:
            return Alert(title: Text(""))
        }
    }
}

//MARK: - Preview
#Preview {
    CategoriesCoordinatorView(store: Store(
        initialState: CategoriesCoordinatorStore.State(),
        reducer: { CategoriesCoordinatorStore() }
    ))
}
