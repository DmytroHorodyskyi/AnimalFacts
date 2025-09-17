//
//  DecoderManager.swift
//  AnimalFacts
//
//  Created by Dmytro Horodyskyi on 17.09.2025.
//

import Foundation
import ComposableArchitecture

protocol IDecoderManager {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

final class DecoderManager: IDecoderManager {
    
    private let decoder: JSONDecoder
    
    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
}

//MARK: - Methods
extension DecoderManager {
    
    func decode<T: Decodable>(
        _ type: T.Type,
        from data: Data
    ) throws -> T {
        try decoder.decode(
            type,
            from: data
        )
    }
}

//MARK: - DependencyKey
extension DecoderManager: DependencyKey {
    
    static let liveValue: IDecoderManager = DecoderManager()
}
