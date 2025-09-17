//
//  CategoryView.swift
//  AnimalFacts
//
//  Created by Dmytro Horodyskyi on 16.09.2025.
//

import SwiftUI
import ComposableArchitecture

struct CategoryView: View {
    
    let store: StoreOf<CategoryStore>
    
    //MARK: Body
    var body: some View {
        WithPerceptionTracking {
            ZStack {
                cardBackground
                cardContent
                if store.category.statusValue == .comingSoon {
                    comingSoonOverlay
                }
            }
            .overlay(
                store.category.statusValue == .comingSoon ?
                Colors.black.color.opacity(0.6) :
                        .clear
            )
            .cornerRadius(6)
            .shadow(color: Colors.black.color.opacity(0.3), radius: 2, x: 0, y: 4)
            .padding(.horizontal)
        }
    }
}

//MARK: - Subviews
private extension CategoryView {
    
    var cardBackground: some View {
        RoundedRectangle(cornerRadius: 6)
            .fill(Colors.white.color)
    }
    
    var cardContent: some View {
        HStack {
            categoryImage
            VStack(alignment: .leading) {
                categoryTitle
                categoryDescription
                Spacer()
                if store.category.statusValue == .paid {
                    premiumStatus
                }
            }
            .padding(8)
        }
    }
    
    var categoryImage: some View {
        AsyncImageView(
            url: URL(string: store.category.image),
            defaultImage: Images.paw.uiImage
        )
        .frame(width: 121, height: 90, alignment: .top)
        .clipped()
        .padding(5)
    }
    
    var categoryTitle: some View {
        Text(store.category.title)
            .font(Fonts.regular16.font)
            .foregroundStyle(Colors.black.color)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var categoryDescription: some View {
        Text(store.category.descriptionText)
            .font(Fonts.regular14.font)
            .foregroundStyle(Colors.black.color.opacity(0.5))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var premiumStatus: some View {
        HStack(spacing: 4) {
            Images.lock.image
            Text("Premium")
                .font(Fonts.regular16.font)
                .foregroundStyle(Colors.accentBlue.color)
        }
    }
    
    var comingSoonOverlay: some View {
        HStack {
            Spacer()
            Images.comingSoonMark.image
        }
    }
}

//MARK: - Preview
#Preview {
    CategoryView(
        store: Store(
            initialState: CategoryStore.State(category: FactCategory(
                title: "Title",
                descriptionText: "Subscription",
                image: "some image url",
                order: 0,
                status: "paid",
                content: []
            )),
            reducer: { CategoryStore() }
        )
    )
}
