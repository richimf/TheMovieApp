//
//  LocalDataManager.swift
//  TheMovieApp
//
//  Created by Ricardo Montesinos on 10/4/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

// MARK: - IMAGE CACHE SINGLETON
public class LocalDataManager {
  
  static let shared = LocalDataManager()
  
  private(set) var imageCache: NSCache<NSString, UIImage> = NSCache<NSString, UIImage>()

  init() {}

}
