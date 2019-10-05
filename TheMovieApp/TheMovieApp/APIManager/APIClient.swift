//
//  APIManager.swift
//  TheMovieApp
//
//  Created by Richie on 10/3/19.
//  Copyright © 2019 Rappi. All rights reserved.
//
// Examples:
// https://api.themoviedb.org/3/movie/popular?api_key=157b108f1f2d275c12e9092b4b2bcdd9
//
import Foundation
import Alamofire
import AlamofireObjectMapper

class APIClient {
  
  var delegate: APIResponseProtocol?
  
  init() {}

  func fetchMovieListOf(url: APIUrls, release: APIMovieParams, lang: MovieLanguage) {
    let URL = url.rawValue + release.rawValue
    let params = [APIParams.key.rawValue: RequestValues().key,
                  APIParams.lang.rawValue: lang.rawValue]
    print(URL)
    Alamofire.request(URL, parameters: params).responseObject { (response: DataResponse<MovieResults>) in
      switch response.result {
      case .success(var results):
        results.release = release
        self.delegate?.fetchedResult(data: results)
      case .failure(let error):
        self.delegate?.onFailure(error)
      }
    }
  }
}
