//
//  APIClientMock.swift
//  TheMovieAppTests
//
//  Created by Richie on 08/10/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import Foundation
import ObjectMapper
@testable import TheMovieApp

class APIClientMock {
  var delegate: APIResponseProtocol?
  var shouldSucceed = true
  
  private let mockJson: String = "{\"page\": 1, \"total_results\": 10000, \"total_pages\": 500,\"results\": [{\"popularity\": 625.548,\"vote_count\": 1349,\"video\": false,\"poster_path\": \"/v0eQLbzT6sWelfApuYsEkYpzufl.jpg\",\"id\": 475557,\"adult\": false,\"backdrop_path\": \"/f5F4cRhQdUbyVbB5lTNCwUzD6BP.jpg\",\"original_language\": \"en\",\"original_title\": \"Joker\",\"genre_ids\": [80, 18, 53], \"title\": \"Guasón\", \"vote_average\": 8.7, \"overview\": \"oscuro.\", \"release_date\": \"2019-10-04\"}]}"

}
extension APIClientMock: APIClientProtocol {
  
  func fetchMovieListOf(url: APIUrls, release: APIMovieParams, lang: MovieLanguage) {
    if shouldSucceed {
      var movies: MovieResults?
      movies = Mapper<MovieResults>().map(JSONString: mockJson)
      self.delegate?.fetchedResult(data: movies ?? MovieResults())
    } else {
      
    }
  }
  
  func fetchGenreListOf(url: APIUrls, release: APIMovieParams, lang: MovieLanguage) {
    
  }
  
  func fetchYouTubeKey(of movie: Movie, completion: @escaping (String?) -> Void) {
    
  }
}
