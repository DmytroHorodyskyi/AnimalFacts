//
//  NetworkManager.swift
//  AnimalFacts
//
//  Created by Dmytro Horodyskyi on 16.09.2025.
//

import Foundation
import ComposableArchitecture

protocol INetworkManager {
    func get<T: Decodable>(_ networkPath: NetworkPath) async throws -> T
}

final class NetworkManager: INetworkManager {
    
    //MARK: Properties
    private let baseURL = "https://raw.githubusercontent.com/AppSci/promova-test-task-iOS/main"
    private let session: URLSession
    private let loggerManager: ILoggerManager
    private let decoderManager: IDecoderManager
    
    //MARK: Initialization
    init(
        session: URLSession = URLSession.shared,
        loggerManager: ILoggerManager,
        decoderManager: IDecoderManager
    ) {
        self.session = session
        self.loggerManager = loggerManager
        self.decoderManager = decoderManager
    }
}

//MARK: - Methods
extension NetworkManager {
    
    func get<T: Decodable>(_ networkPath: NetworkPath) async throws -> T {
        guard let url = URL(string: baseURL + networkPath.path)
        else { throw NetworkError.invalidURL }
        
        do {
            let (data, response) = try await session.data(from: url)
            loggerManager.logResponse(data, response)
            
            if let http = response as? HTTPURLResponse,
               !(200...299).contains(http.statusCode)
            {
                loggerManager.logError(NetworkError.badResponse(statusCode: http.statusCode))
                throw NetworkError.badResponse(statusCode: http.statusCode)
            }
            
            do {
                let value = try decoderManager.decode(
                    T.self,
                    from: data
                )
                return value
            } catch {
                loggerManager.logError(error)
                throw NetworkError.decodingError(error)
            }
        } catch let error as URLError {
            loggerManager.logError(error)
            throw NetworkError.underlying(error)
        } catch let error as NetworkError {
            loggerManager.logError(error)
            throw error
        } catch {
            loggerManager.logError(error)
            throw NetworkError.underlying(error)
        }
    }
}

//MARK: - DependencyKey
extension NetworkManager: DependencyKey {
    
    static let liveValue: INetworkManager = {
        let loggerManager = DependencyValues._current.loggerManager
        let decoderManager = DependencyValues._current.decoderManager
        return NetworkManager(
            loggerManager: loggerManager,
            decoderManager: decoderManager
        )
    }()
}
