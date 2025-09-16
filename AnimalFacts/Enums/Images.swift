//
//  Images.swift
//  AnimalFacts
//
//  Created by Dmytro Horodyskyi on 16.09.2025.
//

import SwiftUICore

enum Images: String {
    
    case arrowLeftInCircle
    case arrowRightInCircle
    case comingSoonMark
    case lock
    
    var image: Image {
        Image(rawValue)
    }
}
