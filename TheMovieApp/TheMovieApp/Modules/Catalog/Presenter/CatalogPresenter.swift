//
//  CatalogPresenter.swift
//  TheMovieApp
//
//  Created by Ricardo Montesinos on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

class CatalogPresenter: CatalogPresenterProtocol {
  
  // MARK: - VIPER
  weak var view: CatalogViewProtocol?
  var interactor: CatalogInteractorInputProtocol?
  var router: CatalogRouterProtocol?
  
  // FILTERING
  var showSearchResults: Bool = false
  private let resultsTitle: String = "Resultados"
  
  // MARK: - REQUEST DATA
  func loadMoviesData() {
    interactor?.fetchMoviesData()
  }
  
  // MARK: - GET DATA
  func getImageCache() -> NSCache<NSString, UIImage>? {
    return interactor?.cacheDataManager.imageCache
  }
  
  func getImageFromLocalStorage(key: String) -> UIImage? {
    return interactor?.getImageFromLocalStorage(key: key)
  }
  
  func getItemAt(indexPath: IndexPath) -> Movie? {
    return interactor?.getItemAt(indexPath, isFiltering: showSearchResults)
  }
  
  func getNumberOfSections() -> Int {
    if showSearchResults {
      return 1
    }
    return interactor?.getSections().count ?? 0
  }
  
  func getNumberOfItemsAt(_ index: Int) -> Int {
    return interactor?.getNumberOfItemsAt(index, isFiltering: showSearchResults) ?? 0
  }
  
  func getSections() -> [String] {
    return interactor?.getSections() ?? []
  }
  
  func getNameForSection(_ section: Int) -> String {
    if showSearchResults {
      return resultsTitle
    }
    let sections = getSections()
    return sections[section]
  }
  
  // MARK: - SHOW VIEWS
  func showDetailView(for movie: Movie, from view: UIViewController) {
    router?.presentMovieDetailView(for: movie, from: view)
  }
  
  func showFilterView(from view: UIViewController) {
    guard let genres = interactor?.genresCategories else { return }
    let ids = interactor?.genresFilteredIds ?? []
    router?.presentCategoryFilterView(from: view, categories: genres, filteredIds: ids, delegate: self)
  }
  
  func showVideoPreview(for movie: Movie, from view: UIViewController) {
    let apiclient = APIClient()
    apiclient.fetchYouTubeKey(of: movie) { videoKey in
      if let key = videoKey {
        self.router?.presentVideoPreview(from: view, with: key)
      }
    }
  }
  
  // MARK: - FILTERING SEARCH
  func filterSearch(input: String, completion: () -> Void) {
    interactor?.filterSearch(text: input)
    completion()
  }
  
  func filterGenres(input: [Int], completion: () -> Void) {
    interactor?.filterByGenre(input)
    completion()
  }
  
  // MARK: - CUSTOMIZATION
  func setupSegmentedControl(control: inout UISegmentedControl) {
    customizeTextColorTo(control: &control)
    var index = 0
    let sections = getSections()
    control.removeAllSegments()
    sections.forEach {
      control.insertSegment(withTitle: $0, at: index, animated: false)
      index += 1
    }
    control.selectedSegmentIndex = 0
    if control.numberOfSegments > 1 {
      control.isHidden = false
      control.isEnabled = !showSearchResults
    }
  }
  
  private func customizeTextColorTo(control: inout UISegmentedControl) {
    let mainTextAtt = [NSAttributedString.Key.foregroundColor: Colors().Main]
    let unselectedTextAtt = [NSAttributedString.Key.foregroundColor: Colors().BlackSoft]
    control.setTitleTextAttributes(mainTextAtt, for: .selected)
    control.setTitleTextAttributes(unselectedTextAtt, for: .normal)
  }
}

// MARK: - RECEIVED FROM INTERACTOR
extension CatalogPresenter: CatalogInteractorOutputProtocol {
  func updateData() {
    view?.loadMovies()
  }
  
  func receivedError(_ error: Error){
    view?.showErrorMessage("")
  }
}

// MARK: - RECEIVED FILTERED GENERS SECTIONS
extension CatalogPresenter: CategoryFilterDelegate {
  func filteredSections(ids: [Int]) {
    // showSearchResults PERMITS to get filter item on catalog view
    showSearchResults = ids.count > 0
    interactor?.filterByGenre(ids)
    view?.loadMovies()
  }
}
