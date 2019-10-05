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
}

public enum MovieCategories: String {
  case popular = "Popular"
  case topRated = "Top Rated"
  case upcoming = "Upcoming"
}

public enum MovieLanguage: String {
  case US = "en-US"
  case MX = "es-MX"
}

// MARK: API
public enum APIUrls: String {
  case movie = "https://api.themoviedb.org/3/movie/"
  case img = "http://image.tmdb.org/t/p/w500/"
  case tv = "https://api.themoviedb.org/3/tv/"
  case genreMovie = "https://api.themoviedb.org/3/genre/movie/list"
  case genreTV = "https://api.themoviedb.org/3/genre/tv/list"
}

public enum APIParams: String {
  case key = "api_key"
  case lang = "language"
}

//https://api.themoviedb.org/3/genre/movie/list?api_key=d21684866ab7c4cdf0891ef667519e53&language=es-MX
//https://api.themoviedb.org/3/genre/tv/list?api_key=d21684866ab7c4cdf0891ef667519e53&language=es-MX
//https://api.themoviedb.org/3/movie/genre
//https://api.themoviedb.org/3/movie/upcoming?api_key=157b108f1f2d275c12e9092b4b2bcdd9&language=es-MX

public enum APIMovieParams: String {
  case popular = "popular"
  case topRated = "top_rated"
  case upcoming = "upcoming"
  case none = ""
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
