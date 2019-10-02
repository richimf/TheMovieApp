//
//  MovieDetailPresenter.swift
//  TheMovieApp
//
//  Created by Richie on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import Foundation

class MovieDetailPresenter: MovieDetailPresenterProtocol {
  
  // MARK: - VIPER
  weak var view: MovieDetailViewProtocol?
  var interactor: MovieDetailInteractorInputProtocol?
  var router: MovieDetailRouterProtocol?
  
  private var movie: Movie?
  
  init(movie: Movie) {
    self.movie = movie
  }
  
  func viewDidLoad() {
    guard let movie = self.movie else { return }
    view?.loadDetails(movie)
  }
}
extension MovieDetailPresenter:  MovieDetailInteractorOutputProtocol {
}
