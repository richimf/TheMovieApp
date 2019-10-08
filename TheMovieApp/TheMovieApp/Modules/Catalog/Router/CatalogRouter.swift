//
//  CatalogRouter.swift
//  TheMovieApp
//
//  Created by Ricardo Montesinos on 10/1/19.
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
  
  func presentCategoryFilterView(from view: UIViewController,
                                 categories: [Genre],
                                 filteredIds: [Int],
                                 delegate: CategoryFilterDelegate?) {
    guard let filterView = view.storyboard?.instantiateViewController(withIdentifier: "CategoryFilterViewController") as? CategoryFilterViewController else { return }
    filterView.items = categories
    filterView.delegate = delegate
    filterView.selectedGenresIds = filteredIds
    view.present(filterView, animated: true, completion: nil)
  }
  
  func presentCategoryFilterView(from view: UIViewController, categories: [Genre], filteredIds: [Int],
                                 delegate: CategoryFilterDelegate?, transitionDelegate: UIViewControllerTransitioningDelegate?) {
    guard let filterView = view.storyboard?.instantiateViewController(withIdentifier: "CategoryFilterViewController") as? CategoryFilterViewController else { return }
    filterView.transitioningDelegate = transitionDelegate
    filterView.modalPresentationStyle = .custom
    filterView.items = categories
    filterView.delegate = delegate
    filterView.selectedGenresIds = filteredIds
    view.present(filterView, animated: true, completion: nil)
  }

  func presentVideoPreview(from view: UIViewController, with key: String) {
    guard let videoPreview = view.storyboard?.instantiateViewController(withIdentifier: "VideoPlayerViewController") as? VideoPlayerViewController else { return }
    videoPreview.videoKey = key
    view.present(videoPreview, animated: true, completion: nil)
  }
}
