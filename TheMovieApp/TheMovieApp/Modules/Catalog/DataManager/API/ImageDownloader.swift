//
//  ImageDownloader.swift
//  TheMovieApp
//
//  Created by Richie on 10/7/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

class ImageDownloader {
  // Image Cache Singleton
  private lazy var imageCache = CacheDataManager.shared.imageCache
  private lazy var dataManager = DataManager()
  
  // DOWNLOAD IMAGE METHOD
  func loadCompressedImage(of movie: Movie, completion: @escaping () -> Void ) -> UIImage {
    let size = CGSize(width: 100, height: 140)
    let path = getURL(of: movie)
    let key: NSString = NSString(string: path)
    
    // Get Image Cached
    if let imageCached: UIImage = imageCache.object(forKey: key) {
      return imageCached
    }
    // Download and Compress image to fit container size
    DispatchQueue.global(qos: .background).async {
      guard let url: URL = URL(string: path),
            let newimage = self.downloadAndCompress(url: url, newSize: size) else { return }
      // save image on cache
      self.imageCache.setObject(newimage, forKey: key)
      // Show in UI
      DispatchQueue.main.async {
        // Save in core data
        self.saveImageLocallyWith(key: key as String, and: newimage.pngData())
        completion()
      }
    }
    return UIImage()
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
  
  private func saveImageLocallyWith(key: String, and data: Data?) {
    dataManager.saveImageDataFor(key: key, and: data)
  }
}
