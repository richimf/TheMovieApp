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
  
  func loadMoviesData() {
    interactor?.fetchMoviesData()
  }
  
  func getItemAt(indexPath: IndexPath) -> Movie? {
    return interactor?.getItemAt(indexPath)
  }
  
  func getNumberOfSections() -> Int {
    return interactor?.getSections().count ?? 0
  }

  func getNumberOfItemsAt(_ index: Int) -> Int {
    return interactor?.getNumberOfItems(index) ?? 0
  }

  func getSections() -> [String] {
    return interactor?.getSections() ?? []
  }

  func nameForSection(_ section: Int) -> String {
    let sections = getSections()
    return sections[section]
  }

  func showDetailView(for movie: Movie, from view: UIViewController) {
    router?.presentMovieDetailView(for: movie, from: view)
  }

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
    control.isHidden = false
    control.isEnabled = true
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
    view?.loadMovies()
  }
}
