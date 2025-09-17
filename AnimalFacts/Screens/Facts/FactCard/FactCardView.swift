//
//  FactCardView.swift
//  AnimalFacts
//
//  Created by Dmytro Horodyskyi on 16.09.2025.
//

import SwiftUI
import ComposableArchitecture

struct FactCardView: View {
    
    let store: StoreOf<FactCardStore>
    
    //MARK: Body
    var body: some View {
        WithPerceptionTracking {
            ZStack {
                cardBackground
                VStack(spacing: 0) {
                    factImage
                    factText
                    Spacer()
                    navigationButtons
                }
                .padding()
            }
            .padding(15)
            .aspectRatio(0.77, contentMode: .fit)
        }
    }
}

//MARK: - Subviews
private extension FactCardView {
    
    var cardBackground: some View {
        RoundedRectangle(cornerRadius: 6)
            .foregroundStyle(Colors.white.color)
    }
    
    var factImage: some View {
        AsyncImageView(
            url: URL(string: store.content.image),
            defaultImage: Images.paw.uiImage
        )
        .frame(width: 315, height: 234)
        .clipped()
        .padding(.bottom)
    }
    
    var factText: some View {
        Text(store.content.fact)
            .font(Fonts.regular18.font)
            .foregroundStyle(Colors.black.color)
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
    }
    
    var navigationButtons: some View {
        HStack {
            Button(action: {
                store.send(.previousTapped)
            }, label: {
                Images.arrowLeftInCircle.image
            })
            Spacer()
            Button(action: {
                store.send(.nextTapped)
            }, label: {
                Images.arrowRightInCircle.image
            })
        }
        .padding(8)
    }
}

//MARK: - Preview
#Preview {
    FactCardView(store: Store(
        initialState: FactCardStore.State(
            contentIndex: 0,
            content: FactItem(
                fact: "Unlike humans, cats do not need to blink their eyes on a regular basis to keep their eyes lubricated.",
                image: "https://cdn2.thecatapi.com/images/1lf.jpg"
            )),
        reducer: { FactCardStore() }
    ))
}
