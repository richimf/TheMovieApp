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
  
  func getItem(at: Int) -> Movie {
    let image = UIImage(named: "genericFlyer")
    return Movie(title: "Avengers",
                 description: "Thanos dies",
                 cover: image)
  }
  
  func getNumberOfItems() -> Int {
    return 10
  }
}
extension CatalogPresenter: CatalogInteractorOutputProtocol {
  
}
