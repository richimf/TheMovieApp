//
//  CellHelpers.swift
//  TheMovieApp
//
//  Created by Ricardo Montesinos on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

// MARK: - MOVIE DETAIL INFO HELPER
public class MovieDetails {
  static func formatInfo(of movie: Movie) -> String {
    let rating: Float = movie.rating ?? 0.0
    let votes: Int = movie.voteCount ?? 0
    let date: String = movie.releaseDate ?? ""
    return "\(rating)★  \(votes)✓  \(date)"
  }
}

func getCategoryKeyFrom(name: String) -> APIMovieParams {
  switch name {
  case "popular":
    return APIMovieParams.popular
  case "top_rated":
    return APIMovieParams.topRated
  case "upcoming":
    return APIMovieParams.upcoming
  default:
    return APIMovieParams.none
  }
}
