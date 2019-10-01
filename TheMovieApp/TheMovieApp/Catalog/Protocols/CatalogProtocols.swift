//
//  Protocols.swift
//  TheMovieApp
//
//  Created by Richie on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

// MARK: - VIPER Protocols
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
  func getItem(at: Int) -> Movie
  func getNumberOfItems() -> Int
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

// MARK: - UITABLEVIEWCELL Protocols
protocol MovieTableViewCellDelegate: class {
  func showMovieTrailer()
}


// MARK: - PROTOCOL Definition
protocol UITableViewCellReusableView {
  static func nib() -> UINib
  static func reuseIdentifier() -> String
}
extension UITableViewCellReusableView where Self: UITableViewCell {
  static func nib() -> UINib {
    return UINib(nibName: String(describing: self), bundle: nil)
  }
  static func reuseIdentifier() -> String {
    return String(describing: self)
  }
}
