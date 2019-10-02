//
//  MovieDetailRouter.swift
//  TheMovieApp
//
//  Created by Richie on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import Foundation

class MovieDetailRouter: MovieDetailRouterProtocol {

  class func createMovieTrailerModule(for view: MovieDetailViewController, and movie: Movie) {
    let presenter = MovieDetailPresenter()
    view.presenter?.movie = movie
    view.presenter? = presenter
    view.presenter?.view = view
    view.presenter?.router = MovieDetailRouter()
  }

  func presentMovieTrailer(from view: MovieDetailViewProtocol) {
    //
  }
}
