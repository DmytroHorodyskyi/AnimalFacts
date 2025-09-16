//
//  AsyncImageView.swift
//  AnimalFacts
//
//  Created by Dmytro Horodyskyi on 16.09.2025.
//

import SwiftUI
import UIKit
import ComposableArchitecture

struct AsyncImageView: View {
    
    //MARK: Properties
    private let url: URL?
    private let defaultImage: UIImage
    
    @State private var image: UIImage? = nil
    
    @Dependency(\.imageCacheManager) var imageCacheManager
    
    //MARK: Bocy
    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
        } else {
            ProgressView()
                .onAppear {
                    loadImage()
                }
        }
    }
    
    //MARK: Initialization
    init(
        url: URL?,
        defaultImage: UIImage
    ) {
        self.url = url
        self.defaultImage = defaultImage
    }
}

//MARK: - Methods
private extension AsyncImageView {
    
    func loadImage() {
       guard let url else { return }
       if let cachedImage = imageCacheManager.getImage(for: url) {
           self.image = cachedImage
       } else {
           URLSession.shared.dataTask(with: url) { data, _, _ in
               if let data = data, let downloadedImage = UIImage(data: data) {
                   DispatchQueue.main.async {
                       imageCacheManager.setImage(downloadedImage, for: url)
                       self.image = downloadedImage
                   }
               } else {
                   DispatchQueue.main.async {
                       self.image = self.defaultImage
                   }
               }
           }.resume()
       }
   }
}

//MARK: - Preview
#Preview {
    AsyncImageView(
        url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/2/2b/WelshCorgi.jpeg"),
        defaultImage: UIImage()
    )
}
