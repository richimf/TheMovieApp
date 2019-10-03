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
  
  private var data: [MovieResults] = []
  private var sections: [Release] = []

  func loadMoviesData() {
    interactor?.fetchMoviesData()
  }
  
  func getItem(from section: Int, at index: Int) -> Movie? {
    return data[section].results?[index]
  }
  
  func getNumberOfSections() -> Int {
    return sections.count
  }
  
  func getNumberOfItems() -> Int {
    return data.count
  }
  
  func getSections() -> [String] {
    var sectionsName: [String] = []
    for section in sections {
      let release: MovieRelease = MovieRelease()
      switch section {
      case .popular:
        sectionsName.append(release.popular.title)
      case .upcoming:
        sectionsName.append(release.upcoming.title)
      case .topRated:
        sectionsName.append(release.topRated.title)
      }
    }
    return sectionsName
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
  func setMoviesData(movieResults: MovieResults) {
    self.data.append(movieResults)
    // Append related movies section
    if let category = movieResults.release, !sections.contains(category) {
      sections.append(category)
    }
    // Refresh TableView
    view?.loadMovies()
  }
}
