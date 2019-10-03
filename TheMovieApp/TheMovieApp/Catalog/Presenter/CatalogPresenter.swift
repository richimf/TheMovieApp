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
  private let apiClient = APIClient()

  func loadMoviesData() {
    apiClient.delegate = self
    let movieRelease = MovieRelease().popular.id
    let lang = MovieLanguage.MX.rawValue
    apiClient.getTicker(movieRelease, lang: lang)
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

// MARK: - API RESPONSE
extension CatalogPresenter: APIResponseProtocol {
 func getResult(data: MovieResults) {
  guard let movies = data.results else { return }
  self.data = movies
  view?.loadMovies()
 }
 
 func onFailure(_ error: Error) {
   print("error \(error)")
 }
}

extension CatalogPresenter: CatalogInteractorOutputProtocol {
  //TODO
}
