//
//  APIManager.swift
//  TheMovieApp
//
//  Created by Richie on 10/3/19.
//  Copyright © 2019 Rappi. All rights reserved.
//
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


//  func fetchMovieListOf(release: String, lang: String) {
//    let URL = RequestValues().url + release + "?api_key=" + RequestValues().key + "&" + "language=" + lang
//    print(URL)
//    Alamofire.request(URL).responseObject { (response: DataResponse<MovieResults>) in
//      switch response.result {
//      case .success(let movies):
//        self.delegate?.getResult(data: movies)
//      case .failure(let error):
//        self.delegate?.onFailure(error)
//      }
//    }
//  }

import Foundation
import Alamofire
import AlamofireObjectMapper

class APIClient {
  
  var delegate: APIResponseProtocol?
  
  init() {}

  func fetchMovieListOf(release: APIMovieParams, lang: MovieLanguage) {
    let URL = RequestValues().url + release.rawValue
    let params = [APIParams.key.rawValue: RequestValues().key,
                  APIParams.lang.rawValue: lang.rawValue]
    Alamofire.request(URL, parameters: params).responseObject { (response: DataResponse<MovieResults>) in
      switch response.result {
      case .success(var movies):
        movies.release = release
        self.delegate?.getResult(data: movies)
      case .failure(let error):
        self.delegate?.onFailure(error)
      }
    }
  }
}
