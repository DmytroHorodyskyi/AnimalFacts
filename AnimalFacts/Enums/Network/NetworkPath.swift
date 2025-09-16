//
//  NetworkPath.swift
//  AnimalFacts
//
//  Created by Dmytro Horodyskyi on 16.09.2025.
//

enum NetworkPath {
    
    case animals
    
    var path: String {
        switch self {
        case .animals:
            return "/animals.json"
        }
    }
}
