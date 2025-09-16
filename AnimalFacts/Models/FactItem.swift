//
//  FactItem.swift
//  AnimalFacts
//
//  Created by Dmytro Horodyskyi on 16.09.2025.
//

import Foundation

struct FactItem: Identifiable, Decodable {
    
    //MARK: Properties
    var id: UUID = UUID()
    let fact: String
    let image: String
    
    //MARK: CodingKeys
    private enum CodingKeys: String, CodingKey {
        case fact
        case image
    }
}
