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
  let popular: (id: APIMovieParams, title: String) = (APIMovieParams.popular, "Popular")
  let topRated: (id: APIMovieParams, title: String) = (APIMovieParams.topRated, "Top Rated")
  let upcoming: (id: APIMovieParams, title: String) = (APIMovieParams.upcoming, "Upcoming")
}

// MARK: API
public enum APIParams: String {
  case key = "api_key"
  case lang = "language"
}

public enum APIMovieParams: String {
  case popular = "popular"
  case topRated = "top_rated"
  case upcoming = "upcoming"
}

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
