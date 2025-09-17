//
//  CategoriesListView.swift
//  AnimalFacts
//
//  Created by Dmytro Horodyskyi on 16.09.2025.
//

import SwiftUI
import ComposableArchitecture

struct CategoriesListView: View {
    
    let store: StoreOf<CategoriesListStore>
    
    //MARK: Body
    var body: some View {
        WithPerceptionTracking {
            ZStack {
                Colors.purpleBackground.color
                    .ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(store.categories, id: \.order) { category in
                            CategoryView(store: Store(
                                initialState: CategoryStore.State(category: category),
                                reducer: { CategoryStore() }
                            ))
                            .onTapGesture {
                                store.send(.didTapCategory(category))
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
                        .scaleEffect(2)
                }
            }
            .onAppear { store.send(.loadCategories) }
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
