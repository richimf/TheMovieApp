//
//  MovieDetailProtocols.swift
//  TheMovieApp
//
//  Created by Richie on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import Foundation

// MARK: - VIPER Protocols
protocol MovieDetailViewProtocol: class {
  var presenter: MovieDetailPresenterProtocol? { get set }
  // PRESENTER -> VIEW
  func loadDetails(_ movie: Movie)
  func showErrorMessage(_ message: String)
}

protocol MovieDetailPresenterProtocol: class {
  var view: MovieDetailViewProtocol? { get set }
  var interactor: MovieDetailInteractorInputProtocol? { get set }
  var router: MovieDetailRouterProtocol? { get set }
  // VIEW -> PRESENTER
  var title: String? { get set }
  func loadDetails()
}

protocol MovieDetailInteractorInputProtocol: class {
  var presenter: MovieDetailInteractorOutputProtocol? { get set }
  // PRESENTER -> INTERACTOR
  // func retreiveMovies()
}

protocol MovieDetailInteractorOutputProtocol: class {
  // INTERACTOR -> PRESENTER
  // TODO
}

protocol MovieDetailRouterProtocol: class {
  // PRESENTER -> ROUTER
  func presentMovieTrailer(from view: MovieDetailViewProtocol)
}
