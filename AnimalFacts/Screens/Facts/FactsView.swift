//
//  FactsView.swift
//  AnimalFacts
//
//  Created by Dmytro Horodyskyi on 16.09.2025.
//

import SwiftUI
import ComposableArchitecture

struct FactsView: View {
    
    @Perception.Bindable var store: StoreOf<FactsStore>    
    
    //MARK: Body
    var body: some View {
        WithPerceptionTracking {
            GeometryReader { geometry in
                WithPerceptionTracking {
                    VStack(spacing: 0) {
                        topShadowGradient
                        mainContent(in: geometry)
                    }
                }
            }
            .background(Colors.purpleBackground.color)
            .navigationTitle(store.title)
            .toolbarRole(.editor)
        }
    }
}

//MARK: - Subviews
private extension FactsView {
    
    var topShadowGradient: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Colors.black.color.opacity(0.25),
                        Colors.black.color.opacity(0)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .frame(height: 8)
    }
    
    func mainContent(in geometry: GeometryProxy) -> some View {
        TabView(selection: $store.currentIndex.sending(\.setCurrentIndex)) {
            ForEachStore(store.scope(state: \.cards, action: \.card)) { cardStore in
                FactCardView(store: cardStore)
                    .tag(cardStore.state.contentIndex)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: geometry.size.height)
        .ignoresSafeArea()
        .animation(.easeInOut(duration: 0.35), value: store.currentIndex)
    }
}

//MARK: - Preview
#Preview {
    FactsView(store: Store(
        initialState: FactsStore.State(
            title: "Dogs",
            contents: [
                FactItem(
                    fact: "The cat appears to be the only domestic companion animal not mentioned in the Bible.",
                    image: "https://cdn2.thecatapi.com/images/av5.jpg"
                ),
                FactItem(
                    fact: "Cats have 32 muscles that control the outer ear (humans have only 6). A cat can independently rotate its ears 180 degrees.",
                    image: "https://cdn2.thecatapi.com/images/a94.jpg"
                ),
                FactItem(
                    fact: "Unlike humans, cats do not need to blink their eyes on a regular basis to keep their eyes lubricated.",
                    image: "https://cdn2.thecatapi.com/images/1lf.jpg"
                )
            ]
        ),
        reducer: { FactsStore() }
    ))
}
