//
//  WebServiceContext.swift
//  TheMovieApp
//
//  Created by Richie on 10/2/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import Foundation

public struct WebServiceContext {

  // The baseURL that remains the same across all requests.
  public let baseURL: URL
  public let sessionConfiguration: URLSessionConfiguration
  
  public init(sessionConfiguration: URLSessionConfiguration, baseURL: URL) {
    self.sessionConfiguration = sessionConfiguration
    self.baseURL = baseURL
  }
}
