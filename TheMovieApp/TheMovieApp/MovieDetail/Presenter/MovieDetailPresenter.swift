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
  
}
extension MovieDetailPresenter:  MovieDetailInteractorOutputProtocol {
}
