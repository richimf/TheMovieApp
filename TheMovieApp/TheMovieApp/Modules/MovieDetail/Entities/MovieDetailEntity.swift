//
//  Entity.swift
//  TheMovieApp
//
//  Created by Richie on 10/7/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import ObjectMapper

public struct Video {
  var id: Int?
  var results: [VideoDetails]?
}
extension Video: Mappable {
  public init?(map: Map) {}
  public mutating func mapping(map: Map) {
    id      = try? map.value("id")
    results = try? map.value("results")
  }
}

public struct VideoDetails {
  var key: String?
}
extension VideoDetails: Mappable {
  public init?(map: Map) {}
  public mutating func mapping(map: Map) {
    key = try? map.value("key")
  }
}
