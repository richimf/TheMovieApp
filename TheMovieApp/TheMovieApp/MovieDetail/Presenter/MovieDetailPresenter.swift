//
//  MovieDetailPresenter.swift
//  TheMovieApp
//
//  Created by Richie on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

class MovieDetailPresenter: MovieDetailPresenterProtocol {
  
  // MARK: - VIPER
  weak var view: MovieDetailViewProtocol?
  var interactor: MovieDetailInteractorInputProtocol?
  var router: MovieDetailRouterProtocol?
  
  private var movie: Movie?
  var title: String?
  
  init(movie: Movie) {
    self.movie = movie
    self.title = movie.title
  }
  
  func loadDetails() {
    guard let movie = self.movie else { return }
    view?.loadDetails(movie)
    interactor?.loadImage(of: movie)
  }
}
extension MovieDetailPresenter:  MovieDetailInteractorOutputProtocol {
  func loadImage(_ image: UIImage) {
    view?.loadImage(image)
  }
}
