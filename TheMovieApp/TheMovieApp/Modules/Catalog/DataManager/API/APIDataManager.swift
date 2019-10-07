//
//  APIDataManager.swift
//  TheMovieApp
//
//  Created by Richie on 10/4/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

class ImageLoader: UIImageView {
  
  private let localDataManager: LocalDataManager = LocalDataManager()
  private var urlImageString: String?
  
  private func getURL(of movie: Movie) -> String {
    guard let path = movie.posterPath else { return "" }
    let fullPath: String = "\(APIUrls.img.rawValue)\(path)"
    return fullPath
  }
  
  func loadImage(of movie: Movie) {
    self.image = nil
    let path = getURL(of: movie)
    let key: NSString = NSString(string: path)
    let imageCache = localDataManager.imageCache
    self.urlImageString = path
    
    // Get Image Cached
    if let imageCached: UIImage = imageCache.object(forKey: key) {
      DispatchQueue.main.async {
        self.image = imageCached
      }
    } else {
      DispatchQueue.global(qos: .background).async {
        guard
          let url: URL = URL(string: path),
          let data = try? Data(contentsOf: url),
          let image: UIImage = UIImage(data: data) else { return }
        // Set image
        DispatchQueue.main.async {
          if self.urlImageString == path {
            imageCache.setObject(image, forKey: key)
          }
        }
      }
    }
  }
}
