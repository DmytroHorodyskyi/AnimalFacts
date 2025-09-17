//
//  DependencyValues+Managers.swift
//  AnimalFacts
//
//  Created by Dmytro Horodyskyi on 16.09.2025.
//

import ComposableArchitecture

extension DependencyValues {
    
    //MARK: LoggerManager
    var loggerManager: ILoggerManager {
        get { self[LoggerManager.self] }
        set { self[LoggerManager.self] = newValue }
    }
    
    //MARK: DecoderManager
    var decoderManager: IDecoderManager {
        get { self[DecoderManager.self] }
        set { self[DecoderManager.self] = newValue }
    }
    
    //MARK: NetworkManager
    var networkManager: INetworkManager {
        get { self[NetworkManager.self] }
        set { self[NetworkManager.self] = newValue }
    }
    
    //MARK: ImageCacheManager
    var imageCacheManager: IImageCacheManager {
        get { self[ImageCacheManager.self] }
        set { self[ImageCacheManager.self] = newValue }
    }
    
    //MARK: StorageManager
    var storageManager: IStorageManager {
        get { self[StorageManager.self] }
        set { self[StorageManager.self] = newValue }
    }
}
