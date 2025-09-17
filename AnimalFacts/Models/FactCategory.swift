//
//  FactCategory.swift
//  AnimalFacts
//
//  Created by Dmytro Horodyskyi on 16.09.2025.
//

import RealmSwift

final class FactCategory: Object, Identifiable, Decodable {
    
    //MARK: Properties
    @Persisted var title: String
    @Persisted var descriptionText: String
    @Persisted var image: String
    @Persisted(primaryKey: true) var order: Int
    @Persisted var status: String
    @Persisted var content: List<FactItem>
    
    //MARK: Simple init
    convenience init(
        title: String,
        descriptionText: String,
        image: String,
        order: Int,
        status: String,
        content: [FactItem]
    ) {
        self.init()
        self.title = title
        self.descriptionText = descriptionText
        self.image = image
        self.order = order
        self.status = status
        self.content.append(objectsIn: content)
    }
    
    // MARK: Decodable init
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.descriptionText = try container.decode(String.self, forKey: .descriptionText)
        self.image = try container.decode(String.self, forKey: .image)
        self.order = try container.decode(Int.self, forKey: .order)
        self.status = try container.decode(String.self, forKey: .status)
        let items = try container.decodeIfPresent([FactItem].self, forKey: .content) ?? []
        self.content.append(objectsIn: items)
    }
}

//MARK: - CodingKeys
extension FactCategory {
    
    private enum CodingKeys: String, CodingKey {
        case title
        case descriptionText = "description"
        case image
        case order
        case status
        case content
    }
}

//MARK: - Methods
extension FactCategory {
    
    var statusValue: Status {
        if content.isEmpty {
            return .comingSoon
        } else {
            return Status(rawValue: status) ?? .comingSoon
        }
    }
}

//MARK: - Status
extension FactCategory {
    
    enum Status: String {
        case paid
        case free
        case comingSoon
    }
}
