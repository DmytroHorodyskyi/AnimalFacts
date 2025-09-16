//
//  CategoriesListView.swift
//  AnimalFacts
//
//  Created by Dmytro Horodyskyi on 16.09.2025.
//

import SwiftUI
import ComposableArchitecture

struct CategoriesListView: View {
    
    //MARK: Properties
    @Perception.Bindable var store: StoreOf<CategoriesListStore>
    
    //MARK: Body
    var body: some View {
        WithPerceptionTracking {
            NavigationView {
                ZStack {
                    Colors.purpleBackground.color.ignoresSafeArea()
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(store.categories, id: \.order) { category in
                                NavigationLink(destination: FactsView()) {
                                    CategoryView(store: Store(
                                        initialState: CategoryStore.State(category: category),
                                        reducer: { CategoryStore() }
                                    ))
                                }
                            }
                        }
                        .padding(.vertical)
                    }
                    .refreshable {
                        store.send(.loadCategories)
                    }
                    if store.isLoading {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .scaleEffect(2)
                    }
                }
            }
            .tint(Colors.black.color)
            .alert(isPresented: Binding(
                get: { store.error != nil },
                set: { _ in store.send(.eraseError) }
            )) {
                Alert(
                    title: Text("Error"),
                    message: Text(store.error ?? ""),
                    dismissButton: .default(Text("Ok"))
                )
                
            }
            .onAppear {
                store.send(.loadCategories)
            }
        }
    }
}

//MARK: - Preview
#Preview {
    CategoriesListView(store: Store(
        initialState: CategoriesListStore.State(),
        reducer: { CategoriesListStore() }
    ))
}
