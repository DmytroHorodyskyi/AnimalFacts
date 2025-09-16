//
//  FactCardView.swift
//  AnimalFacts
//
//  Created by Dmytro Horodyskyi on 16.09.2025.
//

import SwiftUI

struct FactCardView: View {
    
    //MARK: Body
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .foregroundStyle(Colors.white.color)
            VStack(spacing: 15) {
                Image(systemName: "cross")
                    .resizable()
                    .frame(width: 315, height: 234)
                Text("Fact Text ")
                    .font(Fonts.regular18.font)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
                HStack {
                    Button(action: {
                        
                    }, label: {
                        Images.arrowLeftInCircle.image
                    })
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        Images.arrowRightInCircle.image
                    })
                }
                .padding(8)
            }
            .padding()
        }
        .padding(15)
        .aspectRatio(0.77, contentMode: .fit)
    }
}

//MARK: - Preview
#Preview {
    FactCardView()
}
