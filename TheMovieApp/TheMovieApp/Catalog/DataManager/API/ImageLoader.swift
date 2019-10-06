//
//  ImageLoader.swift
//  TheMovieApp
//
//  Created by Richie on 10/4/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

class ImageLoader: UIImageView {
  
  // Image Cache Singleton
  private let imageCache = LocalDataManager.shared.imageCache
  private var urlImageString: String?
  
  // DOWNLOAD IMAGE METHOD
  func loadCompressedImage(of movie: Movie, size: CGSize) {
    let path = getURL(of: movie)
    let key: NSString = NSString(string: path)
    self.urlImageString = path
    self.image = nil
    
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
        DispatchQueue.main.async {
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
}
