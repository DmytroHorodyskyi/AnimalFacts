//
//  ImageCacheManager.swift
//  AnimalFacts
//
//  Created by Dmytro Horodyskyi on 16.09.2025.
//

import UIKit
import ComposableArchitecture

protocol IImageCacheManager {
    func getImage(for url: URL) -> UIImage?
    func setImage(_ image: UIImage, for url: URL)
}

final class ImageCacheManager: IImageCacheManager {
    
    //MARK: Properties
    private var cache = NSCache<NSString, UIImage>()
}

//MARK: - Methods
extension ImageCacheManager {

    func getImage(for url: URL) -> UIImage? {
        return cache.object(forKey: url.absoluteString as NSString)
    }

    func setImage(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url.absoluteString as NSString)
    }
}

//MARK: - DependencyKey
extension ImageCacheManager: DependencyKey {
    
    static let liveValue: IImageCacheManager = ImageCacheManager()
}
