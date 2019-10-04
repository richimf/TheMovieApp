//
//  MovieDetailInteractor.swift
//  TheMovieApp
//
//  Created by Richie on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

class MovieDetailInteractor: MovieDetailInteractorInputProtocol {
  
  // MARK: - VIPER
  weak var presenter: MovieDetailInteractorOutputProtocol?
  
  // CACHE
  var localDataManager: LocalDataManager = LocalDataManager()
  
  var coverImage: UIImage?
  
  func loadImage(of movie: Movie) {
    guard let path = movie.backdropPath else { return }
    let key = NSString(string: "\(movie.id)c")
    let fullPath: String = "\(APIUrls.img.rawValue)\(path)"
    let cache = localDataManager.imageCache
    if let cachedImage = cache.object(forKey: key) {
      self.coverImage = cachedImage
      presenter?.loadImage(cachedImage)
    } else {
      DispatchQueue.global(qos: .background).async {
        guard
          let url: URL = URL(string: fullPath),
          let data = try? Data(contentsOf: url),
          let image: UIImage = UIImage(data: data)
          else { return }
        DispatchQueue.main.async {
          cache.setObject(image, forKey: key)
          self.coverImage = image
          self.presenter?.loadImage(image)
        }
      }
    }
  }

}
