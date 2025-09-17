//
//  Images.swift
//  AnimalFacts
//
//  Created by Dmytro Horodyskyi on 16.09.2025.
//

import SwiftUICore
import UIKit

enum Images: String {
    
    case arrowLeftInCircle
    case arrowRightInCircle
    case comingSoonMark
    case lock
    case paw
}

//MARK: - Methods
extension Images {
    
    var image: Image {
        Image(rawValue)
    }
    
    var uiImage: UIImage {
        UIImage(named: rawValue)!
    }
}
