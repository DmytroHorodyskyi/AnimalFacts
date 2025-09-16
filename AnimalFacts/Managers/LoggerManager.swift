//
//  LoggerManager.swift
//  AnimalFacts
//
//  Created by Dmytro Horodyskyi on 16.09.2025.
//

import Foundation
import ComposableArchitecture

protocol ILoggerManager {
    func logResponse(_ data: Data?, _ response: URLResponse?)
    func logError(_ error: Error)
}

final class LoggerManager: ILoggerManager {
    
}

//MARK: - Methods
extension LoggerManager {
    
    func logResponse(
        _ data: Data?,
        _ response: URLResponse?
    ) {
        guard let httpResponse = response as? HTTPURLResponse else { return }
        let isSuccess = (200...299).contains(httpResponse.statusCode)
        let statusColor = isSuccess ? "🟢" : "🔴"
        print("\(statusColor)---------------------Response-----------------------")
        
        print("""
        |\(httpResponse.statusCode)| \(httpResponse.url?.absoluteString ?? "Unknown URL")
        """)
        if let data = data {
            print("Response Data:\n\(String(decoding: data, as: UTF8.self))")
        } else {
            print("Response Data: No data received")
        }
        
        print("------------------------------------------------------")
    }
    
    func logError(_ error: Error) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentDateTime = dateFormatter.string(from: Date())
        
        let errorType = type(of: error)
        let errorMessage = error.localizedDescription
        let errorStackTrace = (error as CustomStringConvertible).description
        
        print("🔴****************** Error ******************")
        print("Timestamp: \(currentDateTime)")
        print("Error Type: \(errorType)")
        print("Error Message: \(errorMessage)")
        print("Stack Trace: \(errorStackTrace)")
        print("******************************************************")
    }
}

//MARK: - DependencyKey
extension LoggerManager: DependencyKey {
    
    static let liveValue: ILoggerManager = LoggerManager()
}
