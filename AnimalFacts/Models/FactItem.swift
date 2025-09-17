//
//  FactItem.swift
//  AnimalFacts
//
//  Created by Dmytro Horodyskyi on 16.09.2025.
//

import Foundation
import RealmSwift

final class FactItem: Object, Identifiable, Decodable {
    
    //MARK: Properties
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var fact: String
    @Persisted var image: String
    
    convenience init(
        fact: String,
        image: String
    ) {
        self.init()
        self.fact = fact
        self.image = image
    }
}

    //MARK: CodingKeys
extension FactItem {
    
    private enum CodingKeys: String, CodingKey {
        case fact
        case image
    }
}
