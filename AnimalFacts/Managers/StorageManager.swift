//
//  StorageManager.swift
//  AnimalFacts
//
//  Created by Dmytro Horodyskyi on 17.09.2025.
//

import RealmSwift
import ComposableArchitecture

protocol IStorageManager {
    @MainActor
    func saveCategories(_ categories: [FactCategory]) throws
    @MainActor
    func fetchCategories() throws -> [FactCategory]
}


final class StorageManager: IStorageManager {
    
}

//MARK: - Methods
extension StorageManager {
    
    
    func saveCategories(_ categories: [FactCategory]) throws {
        let realm = try Realm()
        try realm.write {
            realm.add(categories, update: .modified)
        }
    }
    
    func fetchCategories() throws -> [FactCategory] {
        let realm = try Realm()
        let results = realm.objects(FactCategory.self)
        return Array(results)
    }
}

//MARK: - DependencyKey
extension StorageManager: DependencyKey {
    
    static let liveValue: any IStorageManager = StorageManager()
}
