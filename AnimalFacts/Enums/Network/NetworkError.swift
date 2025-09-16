//
//  NetworkError.swift
//  AnimalFacts
//
//  Created by Dmytro Horodyskyi on 16.09.2025.
//

enum NetworkError: Error {
    
    case invalidURL
    case badResponse(statusCode: Int)
    case decodingError(Error)
    case underlying(Error)
}
