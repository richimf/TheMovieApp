//
//  Protocols.swift
//  TheMovieApp
//
//  Created by Richie on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import Foundation

protocol CatalogViewProtocol: class {
  var presenter: CatalogPresenterProtocol? { get set}
  // PRESENTER -> VIEW
  func loadMovies(_ movies: [Movie])
  func showErrorMessage(_ message: String)
}

protocol CatalogPresenterProtocol: class {
  var view: CatalogViewProtocol? { get set }
  var interactor: CatalogInteractorInputProtocol? { get set}
  var router: CatalogRouterProtocol? { get set }
  // VIEW -> PRESENTER
  // TODO METHODS
}

protocol CatalogInteractorInputProtocol: class {
  var presenter: CatalogInteractorOutputProtocol? { get set}
  // PRESENTER -> INTERACTOR
  // func retreiveMovies()
}

protocol CatalogInteractorOutputProtocol: class {
  // INTERACTOR -> PRESENTER
  // TODO
}

protocol CatalogRouterProtocol: class {
  // PRESENTER -> ROUTER
  func presentMovieDetailView(from view: CatalogViewProtocol, with items: [Movie])
}
