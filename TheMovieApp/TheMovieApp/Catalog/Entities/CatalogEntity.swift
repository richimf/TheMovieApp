//
//  Movie.swift
//  TheMovieApp
//
//  Created by Ricardo Montesinos on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import ObjectMapper

/// Object used to map all the response from the service
public typealias Category = APIMovieParams
public struct MovieResults {
  var totalPages: Int?
  var results: [Movie]?
  var category: Category?
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
  var id: Int?
  var originalTitle: String?
  var title: String?
  var name: String?
  var overview: String?
  var posterPath: String?
  var popularity: Float?
  var voteCount: Int?
  var rating: Float?
  var backdropPath: String?
  var releaseDate: String?
  var genereIds: [Int]?
  // Images
  var posterImage: Data?
  var backdropImage: Data?
  //
  var category: Category?
}
extension Movie: Mappable {
  public init?(map: Map) {
  }
  public mutating func mapping(map: Map) {
    id             = try? map.value("id")
    originalTitle  = try? map.value("original_title")
    title          = try? map.value("title")
    name           = try? map.value("name")
    overview       = try? map.value("overview")
    posterPath     = try? map.value("poster_path")
    popularity     = try? map.value("popularity")
    voteCount      = try? map.value("vote_count")
    rating         = try? map.value("vote_average")
    backdropPath   = try? map.value("backdrop_path")
    releaseDate    = try? map.value("release_date")
    genereIds      = try? map.value("genre_ids")
  }
}

public struct Genres {
  let categories: [Genre]
}
extension Genres: ImmutableMappable {
  public init(map: Map) throws {
    categories = try map.value("genres")
  }
}

public struct Genre {
  let id: Int
  var name: String?
  var selected: Bool = false
}
extension Genre: ImmutableMappable {
  public init(map: Map) throws {
    id = try map.value("id")
    name = try map.value("name")
  }
}
extension Genre: Equatable {
  public static func == (lhs: Genre, rhs: Genre) -> Bool {
    return lhs.id == rhs.id
  }
}
