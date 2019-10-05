//
//  ImageLoader.swift
//  TheMovieApp
//
//  Created by Richie on 10/4/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

class ImageLoader: UIImageView {
  
  // Image cache singleton
  private let imageCache = LocalDataManager.shared.imageCache
  private var urlImageString: String?
  
  private func getURL(of movie: Movie) -> String {
    guard let path = movie.posterPath else { return "" }
    let fullPath: String = "\(APIUrls.img.rawValue)\(path)"
    return fullPath
  }
  
  func loadImage(of movie: Movie) {
    let path = getURL(of: movie)
    let key: NSString = NSString(string: path)
    self.urlImageString = path
    self.image = nil
    
    // Get Image Cached
    if let imageCached: UIImage = imageCache.object(forKey: key) {
      self.image = imageCached
      return
    }
    // Download Image from API
    DispatchQueue.global(qos: .background).async {
      guard
        let url: URL = URL(string: path),
        let data = try? Data(contentsOf: url),
        let imageDownloaded: UIImage = UIImage(data: data) else { return }
      // Set image
      DispatchQueue.main.async {
        // Avoid overlaping image in cells
        if self.urlImageString == path {
          self.image = imageDownloaded
          self.imageCache.setObject(imageDownloaded, forKey: key)
        }
      }
    }
  }

}
