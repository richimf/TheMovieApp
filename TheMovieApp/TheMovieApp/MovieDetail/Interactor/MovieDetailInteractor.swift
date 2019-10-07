//
//  MovieDetailInteractor.swift
//  TheMovieApp
//
//  Created by Ricardo Montesinos on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

class MovieDetailInteractor: MovieDetailInteractorInputProtocol {
  
  // MARK: - VIPER
  weak var presenter: MovieDetailInteractorOutputProtocol?
  
  // CACHE
  var cacheDataManager: CacheDataManager = CacheDataManager()
  private let dataManager = DataManager()
  
  var coverImage: UIImage?

  func loadImage(of movie: Movie) {
    guard let path = movie.backdropPath else { return }
    let key = NSString(string: "\(String(describing: movie.id))backdropImage")
    let fullPath: String = "\(APIUrls.img.rawValue)\(path)"
    let cache = cacheDataManager.imageCache
    
    // GET FROM LOCAL
    if !Connectivity.isConnectedToInternet {
      let dataManager = DataManager()
      dataManager.retrieveImageDataFrom(key: key as String) { data in
        guard let data = data else { return }
        if let image =  UIImage(data: data) {
          self.presenter?.loadImage(image)
        }
      }
      return
    }
    // LOAD FROM CACHE
    if let cachedImage = cache.object(forKey: key) {
      self.coverImage = cachedImage
      presenter?.loadImage(cachedImage)
    } else {
      // DOWNLOAD
      DispatchQueue.global(qos: .background).async {
        guard
          let url: URL = URL(string: fullPath),
          let data = try? Data(contentsOf: url),
          let image: UIImage = UIImage(data: data)
          else { return }
        DispatchQueue.main.async {
          cache.setObject(image, forKey: key)
          self.saveImageLocallyWith(key: key as String, and: data)
          self.coverImage = image
          self.presenter?.loadImage(image)
        }
      }
    }
  }
  
  func getImageFromLocalStorage(key: String) -> UIImage? {
    // Get image From Local Storage
    var image: UIImage?
    if !Connectivity.isConnectedToInternet {
      dataManager.retrieveImageDataFrom(key: key) { data in
        guard let data = data else { return }
        image =  UIImage(data: data)
      }
    }
    return image
  }

  private func saveImageLocallyWith(key: String, and data: Data?) {
    dataManager.saveImageDataFor(key: key, and: data)
  }

}
