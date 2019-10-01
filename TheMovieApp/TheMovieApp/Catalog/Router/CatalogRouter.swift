//
//  CatalogRouter.swift
//  TheMovieApp
//
//  Created by Richie on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import Foundation

class CatalogRouter: CatalogRouterProtocol {
  
  typealias CatalogPresenterProtocols = CatalogPresenterProtocol & CatalogInteractorOutputProtocol

  class func createModule(view: CatalogViewController) {
    let presenter: CatalogPresenterProtocols = CatalogPresenter()
    view.presenter = presenter
    view.presenter?.router = CatalogRouter()
    view.presenter?.view = view
    view.presenter?.interactor = CatalogInteractor()
    view.presenter?.interactor?.presenter = presenter
  }

  func presentMovieDetailView(from view: CatalogViewProtocol, with items: [Movie]) {
    //TODO
  }
}
