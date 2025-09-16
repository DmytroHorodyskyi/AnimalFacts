//
//  Fonts.swift
//  AnimalFacts
//
//  Created by Dmytro Horodyskyi on 16.09.2025.
//

import SwiftUICore

enum Fonts {
    
    case regular14
    case regular16
    case regular18
    
    var font: Font {
        switch self {
        case .regular14:
                .system(size: 14, weight: .regular)
        case .regular16:
                .system(size: 16, weight: .regular)
        case .regular18:
                .system(size: 18, weight: .regular)
        }
    }
}
