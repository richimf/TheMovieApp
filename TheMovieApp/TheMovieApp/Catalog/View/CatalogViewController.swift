//
//  DetailViewController.swift
//  TheMovieApp
//
//  Created by Richie on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

class CatalogViewController: UIViewController {
  
  // MARK: - VIPER
  var presenter: CatalogPresenterProtocol?
  
  // MARK: - OVERRIDES
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    //presenter?.viewWillAppear()
  }
}

extension CatalogViewController: CatalogViewProtocol {
  func loadMovies(_ movies: [Movie]) {
    // TODO
  }
  
  func showErrorMessage(_ message: String) {
    // TODO
  }
}
