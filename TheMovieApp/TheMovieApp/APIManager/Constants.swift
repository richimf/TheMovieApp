//
//  Constants.swift
//  TheMovieApp
//
//  Created by Richie on 10/2/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import Foundation

// MARK: VALUES
public struct RequestValues {
  let auth: String = "Authorization"
  let key: String = "157b108f1f2d275c12e9092b4b2bcdd9"
  let url: String = "https://api.themoviedb.org/3/movie/"
}

public enum MovieLanguage: String {
  case US = "en-US"
  case MX = "es-MX"
}

public struct MovieRelease {
  let popular: (id: String, title: String) = ("popular", "Popular")
  let topRated: (id: String, title: String) = ("top_rated", "Top Rated")
  let upcoming: (id: String, title: String) = ("upcoming", "Upcoming")
}

// MARK: API
public enum APIRequestMethod {
  case get
  case post
}

public enum APIRequestEncoding {
  case json
  case url
}
public enum APIResponseError: Error {
  case jsonMapping(String)
  case statusCode(Int)
  case badResponse(Any?)
  case unreachableNetwork
  case noNetworkConnection
  case timeout
}
