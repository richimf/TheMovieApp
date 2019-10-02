//
//  Constants.swift
//  TheMovieApp
//
//  Created by Richie on 10/2/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import Foundation

// Examples:
// https://api.themoviedb.org/3/movie/550?api_key=157b108f1f2d275c12e9092b4b2bcdd9
// https://api.themoviedb.org/3/movie/upcoming?api_key=d21684866ab7c4cdf0891ef667519e53&language=es-MX&page=

//GET /movie/{movie_id}/lists
// https://api.themoviedb.org/3/movie/{movie_id}/lists?api_key=<<api_key>>&language=en-US&page=1

// Popular
//https://api.themoviedb.org/3/movie/popular?api_key=<<api_key>>&language=en-US&page=1

// TOP RATED
// https://api.themoviedb.org/3/movie/top_rated?api_key=<<api_key>>&language=en-US&page=1

// UPCOMING
// https://api.themoviedb.org/3/movie/upcoming?api_key=d21684866ab7c4cdf0891ef667519e53&language=es-MX&page=

public enum APIValues: String {
  case key = "157b108f1f2d275c12e9092b4b2bcdd9"
  case url = "https://api.themoviedb.org/3/"
}

public enum Language: String {
  case US = "en-US"
  case MX = "es-MX"
}

//let rea: Release = Release()
//rea.popular.id
//rea.popular.title
public struct MovieRelease {
  let popular: (id: String, title: String) = ("popular", "Popular")
  let topRated: (id: String, title: String) = ("top_rated", "Top Rated")
  let upcoming: (id: String, title: String) = ("upcoming", "Upcoming")
}

