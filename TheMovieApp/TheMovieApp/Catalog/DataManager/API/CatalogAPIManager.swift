//
//  CatalogAPIManager.swift
//  TheMovieApp
//
//  Created by Richie on 10/2/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import Foundation
import Alamofire

class CatalogAPIManager {
  
  // image http://image.tmdb.org/t/p/w500/mMZRKb3NVo5ZeSPEIaNW9buLWQ0.jpg
  // Example
  // https://api.themoviedb.org/3/movie/550?api_key=157b108f1f2d275c12e9092b4b2bcdd9
  private enum APIValues: String {
    case apiKey = "157b108f1f2d275c12e9092b4b2bcdd9"
    case apiv4URL = "https://api.themoviedb.org/4/"
    case apiReadAccesToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNTdiMTA4ZjFmMmQyNzVjMTJlOTA5MmI0YjJiY2RkOSIsInN1YiI6IjVkOTQyZDk3YTA5N2RjMDAyYTIzYWQ3YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.wtBmwCilPPRH7HVyMAt2PP_u3dFOWgHyYV1tM59625E"
  }
  
  // MARK: - AUTH
  
  
  
  // MARK: - RETRIVE MOVIE DATA

  //https://api.themoviedb.org/4/list/1?page=1&api_key=157b108f1f2d275c12e9092b4b2bcdd9&sort_by=original_order.asc
  func getMoviesList(_ book: String) {
    let URL = APIValues.apiv4URL.rawValue
    //    Alamofire.request(URL).responseObject { (response: DataResponse<Ticker>) in
    //      switch response.result {
    //      case .failure( _):
    //        break
    //      case .success(let value):
    //        break
    //      }
    //    }
  }
  
}
