//
//  FactCategory.swift
//  AnimalFacts
//
//  Created by Dmytro Horodyskyi on 16.09.2025.
//

import Foundation

struct FactCategory: Identifiable, Decodable {
    
    //MARK: Properties
    var id: Int { order }
    let title: String
    let description: String
    let image: String
    let order: Int
    let status: String
    let content: [FactItem]?
}

//MARK: - Methods
extension FactCategory {
    
    var statusValue: Status {
        if content?.isEmpty ?? true {
            return .comingSoon
        } else {
            return Status(rawValue: status) ?? .comingSoon
        }
    }
}

//MARK: - FactCategory.Status
extension FactCategory {
    
    enum Status: String {
        case paid
        case free
        case comingSoon
    }
}
