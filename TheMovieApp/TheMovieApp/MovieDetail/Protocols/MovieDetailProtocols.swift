//
//  MovieDetailProtocols.swift
//  TheMovieApp
//
//  Created by Ricardo Montesinos on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

// MARK: - VIPER Protocols
protocol MovieDetailViewProtocol: class {
  var presenter: MovieDetailPresenterProtocol? { get set }
  // PRESENTER -> VIEW
  func loadDetails(_ movie: Movie)
  func loadImage(_ image: UIImage)
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
  var cacheDataManager: CacheDataManager { get set }
  var coverImage: UIImage? { get set }
  // PRESENTER -> INTERACTOR
  func loadImage(of movie: Movie)
}

protocol MovieDetailInteractorOutputProtocol: class {
  // INTERACTOR -> PRESENTER
  func loadImage(_ image: UIImage)
}

protocol MovieDetailRouterProtocol: class {
  // PRESENTER -> ROUTER
  func presentMovieTrailer(from view: MovieDetailViewProtocol)
}
