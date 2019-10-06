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
  
  func loadMoviesData() {
    interactor?.fetchMoviesData()
  }
  
  func getImageCache() -> NSCache<NSString, UIImage>? {
    return interactor?.localDataManager.imageCache
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

  func nameForSection(_ section: Int) -> String {
    if showSearchResults {
      return resultsTitle
    }
    let sections = getSections()
    return sections[section]
  }

  func showDetailView(for movie: Movie, from view: UIViewController) {
    router?.presentMovieDetailView(for: movie, from: view)
  }
  
  // MARK: - FILTERING SEARCH
  func filterSearch(input: String, completion: () -> Void) {
    interactor?.filterSearch(text: input)
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
      control.isEnabled = true
    }
  }

  private func customizeTextColorTo(control: inout UISegmentedControl) {
    let mainTextAtt = [NSAttributedString.Key.foregroundColor: Colors().Main]
    let unselectedTextAtt = [NSAttributedString.Key.foregroundColor: Colors().BlackSoft]
    control.setTitleTextAttributes(mainTextAtt, for: .selected)
    control.setTitleTextAttributes(unselectedTextAtt, for: .normal)
  }
}

// Data received from Interactor
extension CatalogPresenter: CatalogInteractorOutputProtocol {
  func updateData() {
    print(#function)
    view?.loadMovies()
  }
  
  func receivedError(_ error: Error){
    view?.showErrorMessage("")
  }
}
