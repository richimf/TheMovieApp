//
//  CatalogRouter.swift
//  TheMovieApp
//
//  Created by Richie on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

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
  
  func presentMovieDetailView(for movie: Movie, from view: UIViewController) {
    guard let detailView = view.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else { return }
    MovieDetailRouter.createMovieTrailerModule(for: detailView, and: movie)
    view.navigationController?.pushViewController(detailView, animated: true)
  }
}
