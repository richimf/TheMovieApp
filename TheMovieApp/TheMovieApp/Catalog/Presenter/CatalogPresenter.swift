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
    [Movie(title: "Avengers", description: "Thanos dies", cover: UIImage(named: "genericFlyer")),
     Movie(title: "Avengers", description: "Thanos dies", cover: UIImage(named: "genericFlyer")),
     Movie(title: "Avengers", description: "Thanos dies", cover: UIImage(named: "genericFlyer"))]
  
  func getItem(at index: Int) -> Movie {
    return data[index]
  }
  
  func getNumberOfItems() -> Int {
    return data.count
  }
  
  func showDetailView(for movie: Movie) {
    print(#function)
  }
}
extension CatalogPresenter: CatalogInteractorOutputProtocol {
  //TODO
}
