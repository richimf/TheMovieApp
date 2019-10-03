//
//  CatalogInteractor.swift
//  TheMovieApp
//
//  Created by Richie on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import Foundation

class CatalogInteractor: CatalogInteractorInputProtocol {
  
  // MARK: - VIPER
  weak var presenter: CatalogInteractorOutputProtocol?
  private let apiClient = APIClient()
  private var movieResults: MovieResults?
  
  func fetchMoviesData() {
    apiClient.delegate = self
    let popular = MovieRelease().popular.id
    let topRated = MovieRelease().topRated.id
    let upcoming = MovieRelease().upcoming.id
    apiClient.fetchMovieListOf(release: popular, lang: .MX)
    apiClient.fetchMovieListOf(release: topRated, lang: .MX)
    apiClient.fetchMovieListOf(release: upcoming, lang: .MX)
  }
}
// MARK: - API RESPONSE
extension CatalogInteractor: APIResponseProtocol {
  func getResult(data: MovieResults) {
    self.movieResults = data
    presenter?.setMoviesData(movieResults: data)
  }
  
  func onFailure(_ error: Error) {
    print("error \(error)")
  }
}

