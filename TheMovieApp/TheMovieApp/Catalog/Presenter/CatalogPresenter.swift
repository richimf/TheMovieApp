//
//  CatalogPresenter.swift
//  TheMovieApp
//
//  Created by Richie on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

class CatalogPresenter: CatalogPresenterProtocol {
  
  // MARK: - VIPER
  weak var view: CatalogViewProtocol?
  var interactor: CatalogInteractorInputProtocol?
  var router: CatalogRouterProtocol?
  
  private var data:[Movie] = []
  
  func loadMoviesData() {
    // TODO assing data to global variable "data" here
    // data = fetchedMoviesFromServer
    view?.loadMovies()
  }
  
  func getItem(at index: Int) -> Movie {
    return data[index]
  }
  
  func getNumberOfSections() -> Int {
    return 3
  }
  
  func getNumberOfItems() -> Int {
    return data.count
  }
  
  func getSections() -> [String] {
    let release: MovieRelease = MovieRelease()
    return [release.popular.title, release.topRated.title, release.upcoming.title]
  }

  func nameForSection(_ section: Int) -> String {
    let sections = getSections()
    return sections[section]
  }
  
  func setupSegmentedControl(control: inout UISegmentedControl) {
    var index = 0
    let sections = getSections()
    for section in sections {
      control.setTitle(section, forSegmentAt: index)
      index += 1
    }
  }
  
  func showDetailView(for movie: Movie, from view: UIViewController) {
    router?.presentMovieDetailView(for: movie, from: view)
  }
}
extension CatalogPresenter: CatalogInteractorOutputProtocol {
  //TODO
}
