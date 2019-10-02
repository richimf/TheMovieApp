//
//  Movie.swift
//  TheMovieApp
//
//  Created by Richie on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit
import ObjectMapper


/// Object used to map all the response from the service
public struct MovieResults {
  public let totalPages: Int?
  public let results: [Movie]?
}
extension MovieResults: ImmutableMappable {
  public init(map: Map) throws {
    totalPages = try? map.value("total_pages")
    results    = try? map.value("results")
  }
}

public struct Movie {
  var title: String?
  var description: String?
  var posterPath: String?
  var popularity: Float?
  var voteCount: Int?
  var rating: Float?
  var backdropPath: String?
  var releaseDate: String?
}
extension Movie: ImmutableMappable {
  public init(map: Map) throws {
    title          = try? map.value("original_title")
    description    = try? map.value("overview")
    posterPath     = try? map.value("poster_path")
    popularity     = try? map.value("popularity")
    voteCount      = try? map.value("vote_count")
    rating         = try? map.value("vote_average")
    backdropPath   = try? map.value("backdrop_path")
    releaseDate    = try? map.value("release_date")
  }
}
