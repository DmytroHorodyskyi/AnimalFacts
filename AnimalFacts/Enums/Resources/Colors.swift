//
//  Colors.swift
//  AnimalFacts
//
//  Created by Dmytro Horodyskyi on 16.09.2025.
//

import SwiftUICore

enum Colors: String {
    
    case accentBlue
    case black
    case purpleBackground
    case white
}

//MARK: - Methods
extension Colors {
    
    var color: Color {
        Color(rawValue)
    }
}
