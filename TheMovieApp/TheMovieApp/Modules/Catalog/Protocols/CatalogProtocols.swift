//
//  Protocols.swift
//  TheMovieApp
//
//  Created by Ricardo Montesinos on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

// MARK: - VIPER Protocols
protocol CatalogViewProtocol: class {
  var presenter: CatalogPresenterProtocol? { get set}
  // PRESENTER -> VIEW
  func loadMovies()
  func showErrorMessage(_ message: String)
}

protocol CatalogPresenterProtocol: class {
  var view: CatalogViewProtocol? { get set }
  var interactor: CatalogInteractorInputProtocol? { get set}
  var router: CatalogRouterProtocol? { get set }
  var showSearchResults: Bool { get set }
  // VIEW -> PRESENTER
  func getItemAt(indexPath: IndexPath) -> Movie?
  func getSections() -> [String]
  func getNumberOfSections() -> Int
  func getNumberOfItemsAt(_ index: Int) -> Int
  func getNameForSection(_ section: Int) -> String
  func loadMoviesData()
  func setupSegmentedControl(control: inout UISegmentedControl)
  // Show Views
  func showDetailView(for movie: Movie, from view: UIViewController)
  func showFilterView(from view: UIViewController)
  func showVideoPreview(for movie: Movie, from view: UIViewController)
  // FILTERING
  func filterSearch(input: String, completion: () -> Void)
  func filterGenres(input: [Int], completion: () -> Void)
  // IMAGE
  func getImageCache() -> NSCache<NSString, UIImage>?
  func getImageFromLocalStorage(key: String) -> UIImage?
}

protocol CatalogInteractorInputProtocol: class {
  var presenter: CatalogInteractorOutputProtocol? { get set}
  var cacheDataManager: CacheDataManager { get set }
  var genresCategories: [Genre] { get set }
  var genresFilteredIds: [Int] { get set }

  // PRESENTER -> INTERACTOR
  func fetchMoviesData()
  func getNumberOfItemsAt(_ index: Int, isFiltering: Bool) -> Int
  func getSections() -> [String]
  func getItemAt(_ indexPath: IndexPath, isFiltering: Bool) -> Movie?
  func filterSearch(text: String)
  func filterByGenre(_ ids: [Int])
  func getImageFromLocalStorage(key: String) -> UIImage?
}

protocol CatalogInteractorOutputProtocol: class {
  // INTERACTOR -> PRESENTER
  func updateData()
  func receivedError(_ error: Error)
}

protocol CatalogRouterProtocol: class {
  // PRESENTER -> ROUTER
  func presentMovieDetailView(for item: Movie, from view: UIViewController)
  func presentCategoryFilterView(from view: UIViewController, categories: [Genre], filteredIds: [Int], delegate: CategoryFilterDelegate?)
  func presentVideoPreview(from view: UIViewController, with key: String)
}

// MARK: - UITABLEVIEWCELL Protocols
protocol MovieTableViewCellDelegate: class {
  func showMovieTrailer(of movie: Movie)
}

// MARK: - CELL PROTOCOL Definition
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
