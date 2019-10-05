//
//  Movie.swift
//  TheMovieApp
//
//  Created by Richie on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import ObjectMapper

/// Object used to map all the response from the service
public typealias Release = APIMovieParams
public struct MovieResults {
  var totalPages: Int?
  var results: [Movie]?
  var release: Release?
}
extension MovieResults: Mappable {
  public init?(map: Map) {
  }
  public mutating func mapping(map: Map) {
    totalPages = try? map.value("total_pages")
    results    = try? map.value("results")
  }
}

public struct Movie {
  let id: Int
  let originalTitle: String?
  let title: String?
  let name: String?
  let description: String?
  let posterPath: String?
  let popularity: Float?
  let voteCount: Int?
  let rating: Float?
  let backdropPath: String?
  let releaseDate: String?
  let genereIds: [Int]?
}
extension Movie: ImmutableMappable {
  public init(map: Map) throws {
    id             = try map.value("id")
    originalTitle  = try? map.value("original_title")
    title          = try? map.value("title")
    name           = try? map.value("name")
    description    = try? map.value("overview")
    posterPath     = try? map.value("poster_path")
    popularity     = try? map.value("popularity")
    voteCount      = try? map.value("vote_count")
    rating         = try? map.value("vote_average")
    backdropPath   = try? map.value("backdrop_path")
    releaseDate    = try? map.value("release_date")
    genereIds      = try? map.value("genre_ids")
  }
}
