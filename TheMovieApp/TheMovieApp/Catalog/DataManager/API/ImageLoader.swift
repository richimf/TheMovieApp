//
//  ImageLoader.swift
//  TheMovieApp
//
//  Created by Ricardo Montesinos on 10/4/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

class ImageLoader: UIImageView {
  
  // Image Cache Singleton
  private let imageCache = LocalDataManager.shared.imageCache
  private let dataManager = DataManager()
  private var urlImageString: String?
  
  // DOWNLOAD IMAGE METHOD
  func loadCompressedImage(of movie: Movie, size: CGSize) {
    let path = getURL(of: movie)
    let key: NSString = NSString(string: path)
    self.urlImageString = path
    self.image = nil
    
    // Get image From Local Storage
    if !Connectivity.isConnectedToInternet {
      dataManager.retrieveImageDataFrom(key: key as String) { data in
        guard let data = data else { return }
        self.image = UIImage(data: data)
        return
      }
    }
    // Get Image Cached
    if let imageCached: UIImage = imageCache.object(forKey: key) {
      self.image = imageCached
      return
    }
    // Download and Compress image to fit container size
    if self.urlImageString == path {
      DispatchQueue.global(qos: .background).async {
        guard let url: URL = URL(string: path),
          let newimage = self.downloadAndCompress(url: url, newSize: size) else { return }
        // Show in UI
        DispatchQueue.main.async {
          // Save in core data
          self.saveImageLocallyWith(key: key as String, and: newimage.pngData())
          // Set Image
          // if self.urlImageString == path { // avoid repetition but slows scrolling
          self.image = newimage
          // Store new image in cache
          self.imageCache.setObject(newimage, forKey: key)
          // }
        }
      }
    }
  }
  
  // MARK: - PRIVATE METHODS
  // DOWNLOAD AND COMPRESSING IMAGE METHOD
  private func downloadAndCompress(url: URL, newSize: CGSize) -> UIImage? {
    guard let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
      let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil),
      let colorSpace = CGColorSpace(name: CGColorSpace.sRGB) else { return nil }
    let context = CGContext(data: nil,
                            width: Int(newSize.width),
                            height: Int(newSize.height),
                            bitsPerComponent: image.bitsPerComponent,
                            bytesPerRow: image.bytesPerRow,
                            space: image.colorSpace ?? colorSpace,
                            bitmapInfo: image.bitmapInfo.rawValue)
    context?.interpolationQuality = .high
    context?.draw(image, in: CGRect(origin: .zero, size: newSize))
    guard let scaledImage = context?.makeImage() else { return nil }
    return UIImage(cgImage: scaledImage)
  }
  
  // URL CREATOR
  private func getURL(of movie: Movie) -> String {
    guard let path = movie.posterPath else { return "" }
    let fullPath: String = "\(APIUrls.img.rawValue)\(path)"
    return fullPath
  }
  
  private func saveImageLocallyWith(key: String, and data: Data?) {
    dataManager.saveImageDataFor(key: key, and: data)
  }
}
