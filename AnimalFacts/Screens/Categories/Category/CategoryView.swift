//
//  CategoryView.swift
//  AnimalFacts
//
//  Created by Dmytro Horodyskyi on 16.09.2025.
//

import SwiftUI
import ComposableArchitecture

struct CategoryView: View {
    
    //MARK: Properties
    var store: StoreOf<CategoryStore>
    
    //MARK: Body
    var body: some View {
        WithPerceptionTracking {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Colors.white.color)
                HStack {
                    AsyncImageView(
                        url: URL(string: store.category.image),
                        defaultImage: Images.paw.uiImage
                    )
                    .frame(width: 121, height: 90, alignment: .top)
                    .clipped()
                    .padding(5)
                    
                    VStack(alignment: .leading) {
                        Text(store.category.title)
                            .font(Fonts.regular16.font)
                            .foregroundStyle(Colors.black.color)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(store.category.description)
                            .font(Fonts.regular14.font)
                            .foregroundStyle(Colors.black.color.opacity(0.5))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        if store.category.statusValue == .paid {
                            HStack(spacing: 4) {
                                Images.lock.image
                                Text("Premium")
                                    .font(Fonts.regular16.font)
                                    .foregroundStyle(Colors.accentBlue.color)
                            }
                        }
                    }
                    .padding(8)
                }
                if store.category.statusValue == .comingSoon {
                    HStack {
                        Spacer()
                        Images.comingSoonMark.image
                    }
                }
            }
            .overlay(store.category.statusValue == .comingSoon ? Colors.black.color.opacity(0.6) : .clear)
            .cornerRadius(6)
            .shadow(color: Colors.black.color.opacity(0.3), radius: 2, x: 0, y: 4)
            .padding(.horizontal)
        }
    }
}

//MARK: - Preview
#Preview {
    CategoryView(
        store: Store(
            initialState: CategoryStore.State(category: FactCategory(
                title: "Title",
                description: "Subscription",
                image: "some image url",
                order: 0,
                status: "paid",
                content: []
            )),
            reducer: { CategoryStore() }
        )
    )
}
