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
  
  private var data:[Movie] =
    [Movie(title: "Some movie Title", description: "Some long description", cover: UIImage(named: "genericFlyer")),
     Movie(title: "Avengers", description: "Thanos dies", cover: UIImage(named: "genericFlyer")),
     Movie(title: "Avengers", description: "Thanos dies", cover: UIImage(named: "genericFlyer"))]
  
  func getItem(at index: Int) -> Movie {
    return data[index]
  }
  
  func getNumberOfSections() -> Int {
    return 3
  }
  
  func getNumberOfItems() -> Int {
    return data.count
  }
  
  func nameForSection(_ section: Int) -> String {
    return "Name section"
  }
  
  func showDetailView(for movie: Movie, from view: UIViewController) {
    router?.presentMovieDetailView(for: movie, from: view)
  }
}
extension CatalogPresenter: CatalogInteractorOutputProtocol {
  //TODO
}
