//
//  MovieDetailRouter.swift
//  TheMovieApp
//
//  Created by Richie on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import Foundation

class MovieDetailRouter: MovieDetailRouterProtocol {
  
  typealias MovieDetailPresenterProtocols = MovieDetailPresenterProtocol & MovieDetailInteractorOutputProtocol

  class func createMovieTrailerModule(for view: MovieDetailViewController, and movie: Movie) {
    let presenter: MovieDetailPresenterProtocols = MovieDetailPresenter(movie: movie)
    view.presenter = presenter
    view.presenter?.view = view
    view.presenter?.interactor = MovieDetailInteractor()
    view.presenter?.interactor?.presenter = presenter
    view.presenter?.router = MovieDetailRouter()
  }

  func presentMovieTrailer(from view: MovieDetailViewProtocol) {
    //
  }
}
