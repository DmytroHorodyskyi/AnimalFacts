//
//  FactCategory.swift
//  AnimalFacts
//
//  Created by Dmytro Horodyskyi on 16.09.2025.
//

import Foundation

struct FactCategory: Identifiable, Decodable {
    
    var id: UUID = UUID()
    let title: String
    let description: String
    let image: String
    let order: Int
    let status: String
    let content: [FactItem]?
}
